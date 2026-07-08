-- Rung — in-app ratings + feedback. Run AFTER 0001 (needs auth.users).
-- Stores the 1–5 star rating and optional comment a user leaves from the
-- "Rate Rung" sheet. Insert-only for clients: there is NO select policy, so a
-- user can submit but never read anyone's feedback back (you read it in the
-- Supabase dashboard / with the service role). Low ratings are captured here
-- privately instead of being pushed to the public store review.

create table if not exists public.app_feedback (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid references auth.users(id) on delete set null,
  rating      int  not null check (rating between 1 and 5),
  comment     text,
  platform    text,
  app_version text,
  created_at  timestamptz not null default now()
);

alter table public.app_feedback enable row level security;

-- Authenticated users may insert their OWN feedback only.
drop policy if exists app_feedback_insert on public.app_feedback;
create policy app_feedback_insert on public.app_feedback
  for insert to authenticated
  with check (user_id = auth.uid());

-- Intentionally no SELECT/UPDATE/DELETE policy → clients can't read it back.
grant insert on public.app_feedback to authenticated;
