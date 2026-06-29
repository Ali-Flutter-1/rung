-- Rung — publish a few aggregate stats on the profile so pod members can see
-- them (streak / challenges). Only numbers — never attempt history or notes.
-- Visibility is governed by the existing profiles RLS (locked profiles stay
-- hidden, so their stats are hidden too). Run AFTER 0001–0004.

alter table public.profiles
  add column if not exists current_streak   int not null default 0,
  add column if not exists best_streak      int not null default 0,
  add column if not exists total_challenges int not null default 0;
