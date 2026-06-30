-- Rung — device push tokens for chat notifications. Run AFTER 0001.
-- Each row is one device's FCM token, owned by the signed-in user. The app
-- upserts its token on sign-in / token refresh and deletes it on sign-out.
-- Owner-only RLS for the client; the notify edge function reads all members'
-- tokens via the service role (which bypasses RLS).

create table if not exists public.device_tokens (
  token      text primary key,            -- one row per device token
  user_id    uuid not null references auth.users (id) on delete cascade,
  platform   text not null check (platform in ('ios','android','web')),
  updated_at timestamptz not null default now()
);
create index if not exists idx_device_tokens_user on public.device_tokens (user_id);

alter table public.device_tokens enable row level security;

-- A user may only read/write their own token rows. If a device switches
-- accounts, the new account's upsert (token is the PK) reassigns the row.
drop policy if exists device_tokens_rw on public.device_tokens;
create policy device_tokens_rw on public.device_tokens
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());
