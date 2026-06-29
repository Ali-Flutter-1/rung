-- Rung — initial schema for accounts, profiles, pods (groups) & chat.
-- Security model: Row-Level Security on every table. Profiles are private by
-- default-of-design — a member is only visible to people who share a pod with
-- them, and never if they've locked their profile. Pod capacity and the
-- per-tier "how many pods can I join" limits are enforced server-side in the
-- join_group() RPC so a malicious client can't bypass them.

-- ── profiles ──────────────────────────────────────────────────────────────
create table if not exists public.profiles (
  id                uuid primary key references auth.users (id) on delete cascade,
  display_name      text,
  bio               text,
  is_locked         boolean not null default false,
  subscription_tier text not null default 'free'
                      check (subscription_tier in ('free','monthly','yearly')),
  created_at        timestamptz not null default now(),
  updated_at        timestamptz not null default now()
);

-- ── groups (pods) ───────────────────────────────────────────────────────────
create table if not exists public.groups (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  capacity   int  not null default 25 check (capacity between 1 and 50),
  is_system  boolean not null default false,
  created_at timestamptz not null default now()
);

-- ── group_members ───────────────────────────────────────────────────────────
create table if not exists public.group_members (
  group_id  uuid not null references public.groups (id) on delete cascade,
  user_id   uuid not null references public.profiles (id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (group_id, user_id)
);
create index if not exists idx_group_members_user on public.group_members (user_id);

-- ── messages ────────────────────────────────────────────────────────────────
create table if not exists public.messages (
  id         uuid primary key default gen_random_uuid(),
  group_id   uuid not null references public.groups (id) on delete cascade,
  user_id    uuid not null references public.profiles (id) on delete cascade,
  body       text not null check (char_length(body) between 1 and 2000),
  created_at timestamptz not null default now()
);
create index if not exists idx_messages_group on public.messages (group_id, created_at);

-- ── helpers ─────────────────────────────────────────────────────────────────
-- Does the current user share at least one pod with `other`?
create or replace function public.shares_group(other uuid)
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1
    from group_members gm_self
    join group_members gm_other on gm_other.group_id = gm_self.group_id
    where gm_self.user_id = auth.uid()
      and gm_other.user_id = other
  );
$$;

-- Is the current user a member of `gid`?
create or replace function public.is_member(gid uuid)
returns boolean
language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from group_members
    where group_id = gid and user_id = auth.uid()
  );
$$;

-- ── Row-Level Security ──────────────────────────────────────────────────────
alter table public.profiles       enable row level security;
alter table public.groups         enable row level security;
alter table public.group_members  enable row level security;
alter table public.messages       enable row level security;

-- profiles: see your own always; see others only if unlocked AND you share a pod.
drop policy if exists profiles_select on public.profiles;
create policy profiles_select on public.profiles for select using (
  id = auth.uid()
  or (is_locked = false and public.shares_group(id))
);
drop policy if exists profiles_upsert on public.profiles;
create policy profiles_insert on public.profiles for insert
  with check (id = auth.uid());
create policy profiles_update on public.profiles for update
  using (id = auth.uid()) with check (id = auth.uid());

-- groups: visible only to members.
drop policy if exists groups_select on public.groups;
create policy groups_select on public.groups for select
  using (public.is_member(id));

-- group_members: see rosters of pods you belong to; you may remove yourself.
drop policy if exists group_members_select on public.group_members;
create policy group_members_select on public.group_members for select
  using (public.is_member(group_id));
create policy group_members_delete on public.group_members for delete
  using (user_id = auth.uid());
-- NOTE: inserts go through join_group() (security definer) — no direct insert
-- policy, so capacity/tier limits can't be bypassed.

-- messages: read in your pods; post as yourself into your pods.
drop policy if exists messages_select on public.messages;
create policy messages_select on public.messages for select
  using (public.is_member(group_id));
create policy messages_insert on public.messages for insert
  with check (user_id = auth.uid() and public.is_member(group_id));

-- ── join_group RPC — enforces capacity + per-tier pod limit ─────────────────
create or replace function public.join_group(gid uuid)
returns void
language plpgsql security definer set search_path = public as $$
declare
  uid        uuid := auth.uid();
  tier       text;
  cap        int;
  current_n  int;
  joined_n   int;
  max_groups int;
begin
  if uid is null then raise exception 'not authenticated'; end if;

  select subscription_tier into tier from profiles where id = uid;
  tier := coalesce(tier, 'free');

  -- per-tier pod limit: free 1, monthly 3, yearly unlimited (null)
  max_groups := case tier when 'free' then 1 when 'monthly' then 3 else null end;

  select count(*) into joined_n from group_members where user_id = uid;
  if max_groups is not null and joined_n >= max_groups then
    raise exception 'pod limit reached for % tier', tier;
  end if;

  select capacity into cap from groups where id = gid;
  if cap is null then raise exception 'pod not found'; end if;

  select count(*) into current_n from group_members where group_id = gid;
  if current_n >= cap then raise exception 'pod is full'; end if;

  insert into group_members (group_id, user_id)
  values (gid, uid)
  on conflict do nothing;
end;
$$;

-- ── auto-create a profile row on signup ─────────────────────────────────────
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, coalesce(new.raw_user_meta_data->>'display_name', null))
  on conflict (id) do nothing;
  return new;
end;
$$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ── realtime for live chat ──────────────────────────────────────────────────
alter publication supabase_realtime add table public.messages;
alter publication supabase_realtime add table public.group_members;
