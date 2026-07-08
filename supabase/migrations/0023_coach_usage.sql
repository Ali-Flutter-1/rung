-- Rung — AI Coach daily usage counter. Run AFTER 0001 (needs auth.users).
-- Backs the per-user daily message cap the `coach` edge function enforces, so a
-- single account can't run up the Groq bill. Only the edge function (service
-- role) touches this — clients have no policy and can't read/write it.

create table if not exists public.coach_usage (
  user_id uuid not null references auth.users(id) on delete cascade,
  day     date not null default (now() at time zone 'utc')::date,
  count   int  not null default 0,
  primary key (user_id, day)
);

alter table public.coach_usage enable row level security;
-- Intentionally no policies → clients cannot read or write; the edge function
-- uses the service role, which bypasses RLS.

-- Atomically increment today's counter and return the new value. SECURITY
-- DEFINER so the edge function can call it via RPC.
create or replace function public.bump_coach_usage(p_uid uuid)
returns int
language plpgsql
security definer
set search_path = public
as $$
declare
  c int;
begin
  insert into public.coach_usage (user_id, day, count)
  values (p_uid, (now() at time zone 'utc')::date, 1)
  on conflict (user_id, day)
  do update set count = coach_usage.count + 1
  returning count into c;
  return c;
end;
$$;
