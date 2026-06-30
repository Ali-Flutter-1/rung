-- Rung — SAFETY / CAREFUL-FRAMING reframe of four assertiveness rungs.
-- Run AFTER 0007 (content_rungs is created there; this is a content edit, not a
-- schema change). These rungs are cloud-only (sort_order > 10), so they are not
-- in the bundled seed — no app change is needed.
--
-- Why: Rung is for socially anxious people. (1) Telling a user to "stand firm"
-- while someone is ESCALATING, or to "confront unfair treatment head-on", can
-- push them toward the LESS safe choice — de-escalating, disengaging, or leaving
-- is often the wiser, braver move. (2) "End a relationship that isn't working"
-- is a major, irreversible LIFE decision, not a box to tick — an app must not
-- nudge a breakup as a confidence exercise. These rewrites keep the
-- assertiveness intent (you still voice the hard thing) but make staying calm,
-- stepping away, and getting support the strong choice, and hand any big
-- decision back to the user, in their own time. Edits only title / what_to_do /
-- why_it_helps; difficulty, sort_order, est_minutes unchanged; updated_at bumped
-- so the app re-caches.

begin;

-- 19. Low-stakes assertion — keep the rep, but make disengaging an explicit, OK option.
update public.content_rungs set
  title        = 'Calmly speak up when someone cuts in',
  what_to_do   = 'If it feels safe, calmly let someone who jumped the queue know you were next — and if they seem agitated, it''s completely fine to let it go.',
  why_it_helps = 'Speaking up in low-stakes moments builds your voice; choosing not to when something feels off is wisdom, not weakness.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_19';

-- 33. The risky one: was "Stand firm when someone raises their voice".
--     Reframed to staying calm and de-escalating, with full permission to leave.
update public.content_rungs set
  title        = 'Stay calm when someone raises their voice',
  what_to_do   = 'When someone gets loud, keep your own voice low and steady, say your point once if you can — and give yourself full permission to pause, step back, or leave if it stops feeling safe.',
  why_it_helps = 'Staying calm, and choosing to step away when things heat up, is real strength — your safety comes before winning the moment.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_33';

-- 40. Was "Confront ongoing unfair treatment head-on".
--     Reframed to addressing it on your terms, by a safe channel, with support.
update public.content_rungs set
  title        = 'Address an ongoing unfairness, on your terms',
  what_to_do   = 'Pick a calm moment and a way that feels safe — in person, in writing, or with someone alongside you — to name a pattern that''s been treating you unfairly.',
  why_it_helps = 'Naming it your own way, with support if you need it, is how things change — you never have to face it head-on or alone.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_40';

-- 38. Was "End a relationship that isn't working" — a major, irreversible life
--     decision presented as a rung to complete. Reframed so the BRAVE STEP is
--     voicing the hard truth; the decision itself stays the user's own, with
--     support. The app never tells anyone to end a relationship.
update public.content_rungs set
  title        = 'Name what isn''t working in an important relationship',
  what_to_do   = 'Tell someone close, honestly and kindly, about something in the relationship that isn''t working for you — whether to change or end anything is your decision alone, in your own time, and worth talking through with people you trust.',
  why_it_helps = 'Saying the hard thing out loud is the brave step here; what you choose to do next is yours, not a box to tick.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_38';

commit;

-- Sanity check (optional):
-- select id, title, updated_at from public.content_rungs
-- where id in ('rng_assertiveness_19','rng_assertiveness_33','rng_assertiveness_40',
--              'rng_assertiveness_38')
-- order by sort_order;
