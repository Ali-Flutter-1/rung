-- Rung — un-freeze the app's own copy out of custom-rung rows. Run AFTER 0006.
--
-- Older builds wrote the LOCALIZED default text into custom_rungs.what_to_do /
-- why_it_helps at creation time. That text is app copy, not user content: once
-- stored it was stranded in whatever language the rung was created in, and no
-- later language switch would ever update it. Both are now stored empty and
-- rendered from the active locale at display time.
--
-- why_it_helps was NEVER user-authored for a custom rung — the sheet has no
-- field for it — so it is blanked unconditionally. what_to_do is only blanked
-- where it exactly matches the shipped default; anything else is the user's
-- own words and must be left untouched.
--
-- Only the English build ever shipped, so the English default is the only
-- value that can be in the wild. Idempotent.

begin;

update public.custom_rungs
set    why_it_helps = '',
       updated_at   = (extract(epoch from now()) * 1000)::bigint
where  why_it_helps is not null
  and  why_it_helps <> '';

update public.custom_rungs
set    what_to_do = '',
       updated_at = (extract(epoch from now()) * 1000)::bigint
where  what_to_do = 'A challenge you set for yourself.';

commit;

-- Sanity check (uncomment to verify after running):
-- select count(*) filter (where coalesce(why_it_helps, '') <> '') as why_left,
--        count(*) filter (where what_to_do = 'A challenge you set for yourself.') as what_left
-- from public.custom_rungs;
--   → both 0
