-- Rung — pick-able profile avatars. Run AFTER 0001_init.sql.
--
-- Stores the chosen avatar id (e.g. 'fox', 'owl'; see lib/shared/avatars.dart).
-- Nullable → falls back to the display-name initial. It's an identity field, so
-- it rides along with the existing profiles RLS (owner writes, pod-mates read).

alter table public.profiles
  add column if not exists avatar text;
