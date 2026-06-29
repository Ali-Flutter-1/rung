-- Rung — per-user CUSTOM RUNGS backup. Run AFTER 0001–0005.
-- Custom rungs are user-authored content (a title + their own note), so they
-- ARE backed up per user (unlike reflection-note text, which never leaves the
-- device). Owner-only RLS; last-write-wins on updated_at. Free tier is capped
-- at 5 active custom rungs by a trigger; paid tiers are unlimited.
-- IDs are text to match the local SQLite ids.

create table if not exists public.custom_rungs (
  id           text primary key,
  user_id      uuid not null references auth.users (id) on delete cascade,
  track_id     text not null,
  title        text not null,
  what_to_do   text,
  why_it_helps text,
  difficulty   int  not null default 3,
  sort_order   int  not null default 0,
  est_minutes  int  not null default 2,
  updated_at   bigint not null default 0,
  deleted_at   bigint
);
create index if not exists idx_custom_rungs_user
  on public.custom_rungs (user_id, updated_at);

alter table public.custom_rungs enable row level security;

drop policy if exists custom_rungs_rw on public.custom_rungs;
create policy custom_rungs_rw on public.custom_rungs
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Server-side guard for the free-tier cap (defense in depth; the client also
-- checks before inserting). Counts the user's other ACTIVE custom rungs so
-- re-syncing existing rows (upsert) never trips the limit — only a genuinely
-- new 6th active rung is blocked. Paid tiers are unlimited.
create or replace function public.enforce_custom_rung_limit()
returns trigger language plpgsql security definer as $$
declare
  tier text;
  cnt  int;
begin
  if new.deleted_at is not null then
    return new; -- soft-deletes never count against the limit
  end if;
  select subscription_tier into tier from public.profiles where id = new.user_id;
  if tier is null or tier = 'free' then
    select count(*) into cnt from public.custom_rungs
      where user_id = new.user_id and deleted_at is null and id <> new.id;
    if cnt >= 5 then
      raise exception 'custom_rung_limit';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists trg_custom_rung_limit on public.custom_rungs;
create trigger trg_custom_rung_limit
  before insert or update on public.custom_rungs
  for each row execute function public.enforce_custom_rung_limit();
