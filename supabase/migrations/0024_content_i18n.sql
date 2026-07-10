-- Rung — TRANSLATIONS for global content (tracks + rungs). Run AFTER 0007.
--
-- Design: the base tables (content_tracks / content_rungs) stay the canonical
-- source and hold the ENGLISH copy. Translations live in side-tables keyed by
-- (id, locale). Structural fields — track_id, difficulty, sort_order,
-- est_minutes, icon, color_seed, slug — are NEVER duplicated per locale, so
-- retuning a rung's difficulty is one row, not seventeen.
--
-- source_updated_at records the base row's updated_at that a translation was
-- made FROM. When English copy is rewritten (see 0012/0013), updated_at bumps
-- and every translation becomes stale — i.e. it now describes a DIFFERENT
-- exercise than the English does. The client refuses stale rows and falls back
-- to English rather than instructing an anxious user to do the wrong thing.
--
-- Clients fetch only their active locale + fallback chain (pt_PT → pt → en),
-- so the payload stays the size of a single-language pull.

begin;

create table if not exists public.content_track_i18n (
  track_id          text not null references public.content_tracks (id) on delete cascade,
  locale            text not null,
  title             text not null,
  description       text not null,
  source_updated_at bigint not null default 0,
  primary key (track_id, locale)
);

create table if not exists public.content_rung_i18n (
  rung_id           text not null references public.content_rungs (id) on delete cascade,
  locale            text not null,
  title             text not null,
  what_to_do        text not null,
  why_it_helps      text not null,
  source_updated_at bigint not null default 0,
  primary key (rung_id, locale)
);

create index if not exists idx_content_rung_i18n_locale
  on public.content_rung_i18n (locale);
create index if not exists idx_content_track_i18n_locale
  on public.content_track_i18n (locale);

-- Content is global and read-only to clients (managed here in SQL/dashboard).
alter table public.content_track_i18n enable row level security;
alter table public.content_rung_i18n  enable row level security;

drop policy if exists content_track_i18n_read on public.content_track_i18n;
create policy content_track_i18n_read on public.content_track_i18n
  for select using (true);

drop policy if exists content_rung_i18n_read on public.content_rung_i18n;
create policy content_rung_i18n_read on public.content_rung_i18n
  for select using (true);

-- Seed the English rows straight from the base tables. This is deliberately
-- redundant with the base copy: it lets the client exercise the exact same
-- join + fallback path for 'en' as for any other locale, so the plumbing is
-- proven before a single translated string exists. Idempotent.
insert into public.content_track_i18n (track_id, locale, title, description, source_updated_at)
select id, 'en', title, description, 0
from public.content_tracks
on conflict (track_id, locale) do update set
  title = excluded.title,
  description = excluded.description,
  source_updated_at = excluded.source_updated_at;

insert into public.content_rung_i18n (rung_id, locale, title, what_to_do, why_it_helps, source_updated_at)
select id, 'en', title, what_to_do, why_it_helps, updated_at
from public.content_rungs
where deleted_at is null
on conflict (rung_id, locale) do update set
  title = excluded.title,
  what_to_do = excluded.what_to_do,
  why_it_helps = excluded.why_it_helps,
  source_updated_at = excluded.source_updated_at;

commit;

-- Sanity check (uncomment to verify after running):
-- select locale, count(*) from public.content_rung_i18n group by locale;
--   → en | 240
-- Stale-translation detector — should return 0 rows for 'en' right after this:
-- select t.rung_id, t.locale
-- from public.content_rung_i18n t
-- join public.content_rungs r on r.id = t.rung_id
-- where t.source_updated_at < r.updated_at;
