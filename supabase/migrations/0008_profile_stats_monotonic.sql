-- Rung — protect published lifetime stats from being clobbered. Run AFTER 0005.
-- total_challenges and best_streak are lifetime maxima: a device whose local
-- progress was just wiped (account switch) and not yet restored would otherwise
-- push 0 and erase the real number. This trigger keeps them monotonic on update
-- (greatest of old vs new). current_streak is intentionally NOT protected — it
-- legitimately rises and falls with recent activity.

create or replace function public.profiles_stats_monotonic()
returns trigger language plpgsql as $$
begin
  if tg_op = 'UPDATE' then
    new.total_challenges :=
      greatest(coalesce(old.total_challenges, 0), coalesce(new.total_challenges, 0));
    new.best_streak :=
      greatest(coalesce(old.best_streak, 0), coalesce(new.best_streak, 0));
  end if;
  return new;
end;
$$;

drop trigger if exists trg_profiles_stats_monotonic on public.profiles;
create trigger trg_profiles_stats_monotonic
  before insert or update on public.profiles
  for each row execute function public.profiles_stats_monotonic();
