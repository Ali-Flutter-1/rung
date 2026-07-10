-- Rung — drop the content translation tables. Rung/track copy is English-only.
--
-- 0024_content_i18n.sql introduced content_track_i18n / content_rung_i18n so
-- rung copy could be served per-locale. That was reverted: the exercise text is
-- therapeutic content, a mistranslated `what_to_do` sends an anxious person to
-- do the wrong thing, and the review cost was not worth it. The UI is still
-- localized into 17 languages; only the database copy stays English.
--
-- Safe to run whether or not 0024 was ever applied. Idempotent.

begin;

drop table if exists public.content_rung_i18n;
drop table if exists public.content_track_i18n;

commit;

-- Sanity check (uncomment to verify after running):
-- select table_name from information_schema.tables
-- where table_schema = 'public' and table_name like 'content_%_i18n';
--   → 0 rows
