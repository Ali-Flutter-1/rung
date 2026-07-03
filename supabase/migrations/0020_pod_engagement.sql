-- Rung — pod engagement hooks: unread badges, daily prompts, quick check-ins.
-- Run AFTER 0019.

-- ── group_member_state: per-membership read cursor for unread counts ─────────
create table if not exists public.group_member_state (
  group_id      uuid not null,
  user_id       uuid not null,
  last_seen_at  timestamptz not null default now(),
  primary key (group_id, user_id),
  foreign key (group_id, user_id)
    references public.group_members (group_id, user_id)
    on delete cascade
);

alter table public.group_member_state enable row level security;

drop policy if exists gms_select on public.group_member_state;
create policy gms_select on public.group_member_state for select
  using (user_id = auth.uid());

drop policy if exists gms_update on public.group_member_state;
create policy gms_update on public.group_member_state for update
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists gms_insert on public.group_member_state;
create policy gms_insert on public.group_member_state for insert
  with check (user_id = auth.uid());

-- Ensure a state row exists whenever someone joins.
create or replace function public.ensure_member_state()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.group_member_state (group_id, user_id, last_seen_at)
  values (new.group_id, new.user_id, now())
  on conflict (group_id, user_id) do nothing;
  return new;
end;
$$;

drop trigger if exists trg_group_member_state on public.group_members;
create trigger trg_group_member_state
  after insert on public.group_members
  for each row execute function public.ensure_member_state();

-- Backfill existing memberships.
insert into public.group_member_state (group_id, user_id, last_seen_at)
select gm.group_id, gm.user_id, now()
from public.group_members gm
on conflict (group_id, user_id) do nothing;

-- Mark a pod as read now (for unread badges).
create or replace function public.mark_group_seen(gid uuid)
returns void language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then raise exception 'not authenticated'; end if;
  if not public.is_member(gid) then raise exception 'not a member'; end if;
  insert into public.group_member_state (group_id, user_id, last_seen_at)
  values (gid, uid, now())
  on conflict (group_id, user_id)
  do update set last_seen_at = excluded.last_seen_at;
end;
$$;

grant execute on function public.mark_group_seen(uuid) to authenticated;

-- my_pods now includes unread_count.
drop function if exists public.my_pods();
create or replace function public.my_pods()
returns table (
  id uuid,
  name text,
  capacity int,
  is_system boolean,
  member_count bigint,
  unread_count bigint
)
language sql stable security definer set search_path = public as $$
  select
    g.id,
    g.name,
    g.capacity,
    g.is_system,
    (select count(*) from group_members m where m.group_id = g.id) as member_count,
    (
      select count(*)
      from messages msg
      where msg.group_id = g.id
        and msg.user_id <> auth.uid()
        and msg.deleted_at is null
        and msg.created_at > coalesce(
          (select s.last_seen_at from group_member_state s
           where s.group_id = g.id and s.user_id = auth.uid()),
          to_timestamp(0)
        )
    ) as unread_count
  from groups g
  join group_members gm on gm.group_id = g.id
  where gm.user_id = auth.uid()
  order by g.is_system desc, g.name;
$$;

-- ── Daily prompts ────────────────────────────────────────────────────────────
create table if not exists public.pod_prompts (
  id         uuid primary key default gen_random_uuid(),
  group_id    uuid not null references public.groups (id) on delete cascade,
  day_key     text not null,
  prompt      text not null,
  created_at  timestamptz not null default now(),
  unique (group_id, day_key)
);

create index if not exists idx_pod_prompts_group_day
  on public.pod_prompts (group_id, day_key);

alter table public.pod_prompts enable row level security;

drop policy if exists pod_prompts_select on public.pod_prompts;
create policy pod_prompts_select on public.pod_prompts for select
  using (public.is_member(group_id));

-- Returns today's prompt for a pod (creates one deterministically if missing).
create or replace function public.my_pod_prompt(gid uuid)
returns public.pod_prompts
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  key text := to_char(now() at time zone 'utc', 'YYYY-MM-DD');
  prompts text[] := array[
    'What small step felt braver than expected today?',
    'Share one fear prediction that turned out softer in real life.',
    'What is one 2-minute rung you can do before tonight?',
    'What helped you start when anxiety said "not now"?',
    'Name one kind thing you told yourself this week.',
    'What would "good enough" practice look like today?',
    'What is one tiny boundary you can hold kindly today?',
    'What made today''s discomfort worth it?',
    'If a pod-mate feels stuck, what gentle advice would you give?',
    'What rung are you avoiding, and what would make it 10% easier?'
  ];
  idx int;
  row public.pod_prompts%rowtype;
begin
  if uid is null then raise exception 'not authenticated'; end if;
  if not public.is_member(gid) then raise exception 'not a member'; end if;

  select * into row
  from public.pod_prompts
  where group_id = gid and day_key = key
  limit 1;
  if found then return row; end if;

  idx := 1 + (abs(('x' || substr(md5(gid::text || key), 1, 8))::bit(32)::int)
              % array_length(prompts, 1));
  insert into public.pod_prompts (group_id, day_key, prompt)
  values (gid, key, prompts[idx])
  on conflict (group_id, day_key) do update set prompt = public.pod_prompts.prompt
  returning * into row;

  return row;
end;
$$;

grant execute on function public.my_pod_prompt(uuid) to authenticated;

-- ── Quick check-ins ("I did my step") ───────────────────────────────────────
create table if not exists public.pod_checkins (
  group_id    uuid not null references public.groups (id) on delete cascade,
  user_id     uuid not null references public.profiles (id) on delete cascade,
  day_key     text not null,
  created_at  timestamptz not null default now(),
  primary key (group_id, user_id, day_key)
);

create index if not exists idx_pod_checkins_group_day
  on public.pod_checkins (group_id, day_key);

alter table public.pod_checkins enable row level security;

drop policy if exists pod_checkins_select on public.pod_checkins;
create policy pod_checkins_select on public.pod_checkins for select
  using (public.is_member(group_id));

drop policy if exists pod_checkins_insert on public.pod_checkins;
create policy pod_checkins_insert on public.pod_checkins for insert
  with check (user_id = auth.uid() and public.is_member(group_id));

create or replace function public.pod_check_in_today(gid uuid)
returns table (checked_in boolean, today_count bigint)
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  key text := to_char(now() at time zone 'utc', 'YYYY-MM-DD');
begin
  if uid is null then raise exception 'not authenticated'; end if;
  if not public.is_member(gid) then raise exception 'not a member'; end if;

  insert into public.pod_checkins (group_id, user_id, day_key)
  values (gid, uid, key)
  on conflict do nothing;

  return query
    select
      exists(
        select 1 from public.pod_checkins c
        where c.group_id = gid and c.user_id = uid and c.day_key = key
      ) as checked_in,
      (
        select count(*) from public.pod_checkins c
        where c.group_id = gid and c.day_key = key
      ) as today_count;
end;
$$;

create or replace function public.pod_check_in_state(gid uuid)
returns table (checked_in boolean, today_count bigint)
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  key text := to_char(now() at time zone 'utc', 'YYYY-MM-DD');
begin
  if uid is null then raise exception 'not authenticated'; end if;
  if not public.is_member(gid) then raise exception 'not a member'; end if;

  return query
    select
      exists(
        select 1 from public.pod_checkins c
        where c.group_id = gid and c.user_id = uid and c.day_key = key
      ) as checked_in,
      (
        select count(*) from public.pod_checkins c
        where c.group_id = gid and c.day_key = key
      ) as today_count;
end;
$$;

grant execute on function public.pod_check_in_today(uuid) to authenticated;
grant execute on function public.pod_check_in_state(uuid) to authenticated;
