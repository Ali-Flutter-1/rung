-- Rung — per-user notification preference. Run AFTER 0001.
-- `pod_alerts` = does this user want push notifications for new pod messages.
-- The notify-on-message Edge Function skips users who set it false. The master
-- "push on/off" switch is handled client-side by (un)registering the device
-- token, so it needs no column.

alter table public.profiles
  add column if not exists pod_alerts boolean not null default true;
