-- Run AFTER 0011 (needs auth.users). Backs up the streak-freeze "frozen days"
-- so a streak that a freeze was holding together survives a reinstall or an
-- account switch. Only frozen_days needs backing up: the weekly allowance
-- (freeze_week / freezes_remaining) self-heals per tier at the start of each
-- week, so it's fine to lose. One row per user; merged as a union client-side.
begin;

create table if not exists public.backup_streak_freeze (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  frozen_days text not null default '',
  updated_at  timestamptz not null default now()
);

alter table public.backup_streak_freeze enable row level security;

do $$ begin
  create policy "freeze_owner_all" on public.backup_streak_freeze
    for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
exception when duplicate_object then null; end $$;

commit;

-- Sanity check (uncomment to run):
-- select user_id, frozen_days, updated_at from public.backup_streak_freeze;
