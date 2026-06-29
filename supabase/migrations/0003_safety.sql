-- Rung — pod safety & moderation: blocking, reporting, rate-limiting, and
-- block-aware message visibility. Run AFTER 0001 + 0002.
-- This is the non-negotiable safety layer for a community of a vulnerable
-- audience (and a hard requirement for App Store / Play review).

-- ── blocks ──────────────────────────────────────────────────────────────────
create table if not exists public.blocks (
  blocker_id uuid not null references public.profiles (id) on delete cascade,
  blocked_id uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker_id, blocked_id),
  check (blocker_id <> blocked_id)
);
create index if not exists idx_blocks_blocked on public.blocks (blocked_id);

-- ── reports ─────────────────────────────────────────────────────────────────
create table if not exists public.reports (
  id               uuid primary key default gen_random_uuid(),
  reporter_id      uuid not null references public.profiles (id) on delete cascade,
  reported_user_id uuid not null references public.profiles (id) on delete cascade,
  group_id         uuid references public.groups (id) on delete set null,
  message_id       uuid references public.messages (id) on delete set null,
  reason           text,
  status           text not null default 'open'
                     check (status in ('open','reviewed','actioned','dismissed')),
  created_at       timestamptz not null default now()
);
create index if not exists idx_reports_status on public.reports (status, created_at);

alter table public.blocks  enable row level security;
alter table public.reports enable row level security;

-- blocks: manage only your own.
drop policy if exists blocks_select on public.blocks;
create policy blocks_select on public.blocks for select using (blocker_id = auth.uid());
create policy blocks_insert on public.blocks for insert with check (blocker_id = auth.uid());
create policy blocks_delete on public.blocks for delete using (blocker_id = auth.uid());

-- reports: file your own; see your own. (Moderators read via service role.)
drop policy if exists reports_select on public.reports;
create policy reports_select on public.reports for select using (reporter_id = auth.uid());
create policy reports_insert on public.reports for insert with check (reporter_id = auth.uid());

-- ── block-aware message visibility ──────────────────────────────────────────
-- Hide messages from anyone you've blocked AND from anyone who blocked you.
drop policy if exists messages_select on public.messages;
create policy messages_select on public.messages for select using (
  public.is_member(group_id)
  and not exists (
    select 1 from blocks b
    where (b.blocker_id = auth.uid() and b.blocked_id = messages.user_id)
       or (b.blocker_id = messages.user_id and b.blocked_id = auth.uid())
  )
);

-- ── RPCs ────────────────────────────────────────────────────────────────────
create or replace function public.block_user(target uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if target = auth.uid() then raise exception 'cannot block yourself'; end if;
  insert into blocks (blocker_id, blocked_id) values (auth.uid(), target)
  on conflict do nothing;
end; $$;

create or replace function public.unblock_user(target uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  delete from blocks where blocker_id = auth.uid() and blocked_id = target;
end; $$;

-- Report a specific message (derives the reported user + group from it).
create or replace function public.report_message(mid uuid, why text)
returns void language plpgsql security definer set search_path = public as $$
declare m record;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  select user_id, group_id into m from messages where id = mid;
  if m.user_id is null then raise exception 'message not found'; end if;
  insert into reports (reporter_id, reported_user_id, group_id, message_id, reason)
  values (auth.uid(), m.user_id, m.group_id, mid, why);
end; $$;

-- Report a user generally (no specific message).
create or replace function public.report_user(target uuid, gid uuid, why text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  insert into reports (reporter_id, reported_user_id, group_id, reason)
  values (auth.uid(), target, gid, why);
end; $$;

-- ── rate limiting (anti-spam) ───────────────────────────────────────────────
create or replace function public.check_message_rate()
returns trigger language plpgsql security definer set search_path = public as $$
declare recent int;
begin
  select count(*) into recent from messages
   where user_id = new.user_id
     and created_at > now() - interval '60 seconds';
  if recent >= 12 then
    raise exception 'rate_limited: take a breath — too many messages too fast';
  end if;
  return new;
end; $$;

drop trigger if exists trg_message_rate on public.messages;
create trigger trg_message_rate before insert on public.messages
  for each row execute function public.check_message_rate();
