-- Rung — back up DAILY CHECK-INS. Run AFTER 0001–0027.
--
-- The check-in is what the streak counts (showing up, not completing a step),
-- so without this a reinstall silently resets the one number users care most
-- about keeping. Same shape and privacy stance as 0004: numbers and a mood
-- label only — no free text ever leaves the device (§1.9).
--
-- `day` is the local calendar day as 'YYYY-MM-DD', exactly as stored in the
-- device's `check_ins` table, so rows merge without timezone arithmetic.
-- Owner-only RLS; last-write-wins on updated_at.

create table if not exists public.backup_check_ins (
  user_id    uuid not null references auth.users (id) on delete cascade,
  day        text not null,
  mood       text not null,
  created_at bigint not null default 0,
  updated_at bigint not null default 0,
  primary key (user_id, day)
);

create index if not exists idx_backup_check_ins_user
  on public.backup_check_ins (user_id, updated_at);

alter table public.backup_check_ins enable row level security;

drop policy if exists backup_check_ins_rw on public.backup_check_ins;
create policy backup_check_ins_rw on public.backup_check_ins
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
