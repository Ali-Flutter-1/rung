-- Rung — opt-in PROGRESS BACKUP (numbers only). Run AFTER 0001–0003.
-- Privacy-first (§1.9): we back up streaks/attempts so users don't lose them on
-- reinstall, but reflection-note / prediction-note FREE TEXT is intentionally
-- NOT stored here — there are no note columns, so notes can never leave the
-- device. Owner-only RLS. Client stays the source of truth; last-write-wins on
-- updated_at. IDs are text to match the local SQLite ids.

create table if not exists public.backup_attempts (
  id             text primary key,
  user_id        uuid not null references auth.users (id) on delete cascade,
  rung_id        text not null,
  predicted_suds int,
  actual_suds    int,
  outcome        text,
  started_at     bigint,
  completed_at   bigint,
  created_at     bigint,
  updated_at     bigint not null default 0,
  deleted_at     bigint
);
create index if not exists idx_backup_attempts_user
  on public.backup_attempts (user_id, updated_at);

create table if not exists public.backup_progress (
  user_id                  uuid not null references auth.users (id) on delete cascade,
  track_id                 text not null,
  current_rung_id          text,
  rungs_cleared            int  not null default 0,
  streak                   int  not null default 0,
  streak_freezes_remaining int  not null default 1,
  last_activity_day        text,
  updated_at               bigint not null default 0,
  primary key (user_id, track_id)
);

alter table public.backup_attempts enable row level security;
alter table public.backup_progress enable row level security;

-- Owner-only: a user can only ever see/write their own backup rows.
drop policy if exists backup_attempts_rw on public.backup_attempts;
create policy backup_attempts_rw on public.backup_attempts
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists backup_progress_rw on public.backup_progress;
create policy backup_progress_rw on public.backup_progress
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
