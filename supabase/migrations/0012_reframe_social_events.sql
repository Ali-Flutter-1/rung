-- Rung — REFRAME of social-events rungs that quietly assumed extroversion.
-- Run AFTER 0007 (content_rungs is created there; this is a content edit, not a
-- schema change).
--
-- Why: the ladder is a social-ANXIETY tool. Six social_events rungs framed
-- normal introvert behaviour (leaving when done, declining to protect energy,
-- preferring smaller) as failures to overcome, and set "become the social hub"
-- as the finish line. These rewrites keep the exposure-therapy intent (don't
-- let panic drive the exit; say yes to the *nervous* no) while making a chosen
-- exit and a self-sized goal count as wins. Copy is PATH-NEUTRAL: it works for
-- both "more social" and "more comfortable when social" users, so no fork column
-- is required to ship it.
--
-- Edits only: title / what_to_do / why_it_helps. difficulty, sort_order and
-- est_minutes are left untouched. updated_at is bumped (transaction start time,
-- identical across all six) so the app re-fetches and re-caches these rows.

begin;

-- 1. Say yes — but only to the nervous no, not the "I genuinely need rest" no.
update public.content_rungs set
  what_to_do   = 'Accept an invite you''d usually turn down out of nerves — not one you''d skip because you honestly need the rest.',
  why_it_helps = 'Saying yes to the nervous no, not every no, is how showing up gets easier.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_01';

-- 2. 15-minute floor — leaving after the floor is a win, not a bail.
update public.content_rungs set
  what_to_do   = 'Arrive, get a drink, and give yourself a 15-minute floor — then stay or head off, your call.',
  why_it_helps = 'A small, bounded goal makes the doorway easy, and choosing to leave after still counts.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_02';

-- 3. Stay an hour — keep the evidence-building, drop the "outlast everyone".
update public.content_rungs set
  what_to_do   = 'Give yourself an hour, then leave freely once it''s up — no need to outlast anyone.',
  why_it_helps = 'Tolerating the hour builds evidence you can handle it, and a chosen exit is part of the win.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_05';

-- 4. Biggest offender: was "stay until it winds down" (grind to the bitter end).
--    Reframed to the real skill — leaving on a chosen moment, not a panicked one.
update public.content_rungs set
  title        = 'Leave when you choose, not when you panic',
  what_to_do   = 'Notice the first urge to bolt, let it pass, and leave a little later at a moment you pick.',
  why_it_helps = 'The difference between fleeing and choosing to go is the whole skill — and a deliberate exit always counts.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_20';

-- 5. Was "party with 15+ guests" — a fixed headcount as the goal.
--    Reframed so the stretch is past YOUR line, whatever the number.
update public.content_rungs set
  title        = 'Host at a scale that stretches you',
  what_to_do   = 'Host a gathering bigger than your usual — the size that feels like a real stretch for you, not a fixed headcount.',
  why_it_helps = 'Growth is hosting past your own comfort line, whatever that number is, not hitting someone else''s.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_38';

-- 6. The extrovert "finish line": was "become the regular host of your circle".
--    Reframed to mastery-on-your-terms — the true summit for both user types.
update public.content_rungs set
  title        = 'Show up as fully yourself, on your terms',
  what_to_do   = 'Reach the point where social events feel like yours to shape — joining, hosting, or leaving exactly as suits you, without dread.',
  why_it_helps = 'The summit isn''t being the busiest person in the room; it''s social life on your own terms, with the fear gone.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_40';

commit;

-- Sanity check (optional): confirm six rows now carry the new timestamp.
-- select id, title, updated_at from public.content_rungs
-- where id in ('rng_social_events_01','rng_social_events_02','rng_social_events_05',
--              'rng_social_events_20','rng_social_events_38','rng_social_events_40')
-- order by sort_order;
