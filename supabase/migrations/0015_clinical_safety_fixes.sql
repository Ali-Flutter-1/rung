-- Rung — clinical-safety + grading polish from the content audit. Run AFTER 0007.
-- All edits are content-only (title / what_to_do / why_it_helps / difficulty);
-- updated_at bumped so the app re-caches. Idempotent.

begin;

-- ── Safety reframes ─────────────────────────────────────────────────────────

-- approaching_40: the whole track no longer ENDS on "ask out someone who
-- intimidates you" (could steer toward a power-imbalance / red-flag person).
-- The summit is the ASK, not conquering an intimidating target.
update public.content_rungs set
  title        = 'Ask out someone you really like',
  what_to_do   = 'Invite someone you''re genuinely drawn to to do something specific together — the brave part is the asking, whatever they say.',
  why_it_helps = 'The win is making the ask and surviving the wait — their answer is data, not a verdict on you.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_approaching_40';

-- assertiveness_30: holding a "no" through guilt can be unsafe in a controlling
-- dynamic. Name that the guilt-tripper may be the problem; leaving is allowed.
update public.content_rungs set
  what_to_do   = 'With someone safe, hold a small no even when they lay on guilt. If holding a boundary with this person ever feels unsafe, that''s important to notice — not a step to push through.',
  why_it_helps = 'Your needs are allowed to matter — and noticing when a no feels unsafe is wisdom, not weakness.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_30';

-- assertiveness_37: mirror the 0013 safety pattern — disengaging is the strong
-- move if pushback turns heated.
update public.content_rungs set
  what_to_do   = 'Keep your limit in place as someone tries to talk you out of it — and if the pushback turns heated or frightening, stepping away is the strong move, not the weak one.',
  why_it_helps = 'Holding a calm boundary is strength; so is choosing to disengage the moment it stops feeling safe.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_37';

-- visibility_38: exposure never needs broadcasting private pain. Scope from a
-- "wide audience" down to trusted people.
update public.content_rungs set
  title        = 'Share something a little vulnerable with people you trust',
  what_to_do   = 'Tell people whose response you trust something real and a bit tender — an honest "I found that hard", a soft preference, a genuine worry.',
  why_it_helps = 'Being a little open with safe people is the brave step — vulnerability never has to mean broadcasting private pain.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_visibility_38';

-- pressure_36: the lesson is "a hitch is survivable", not "engineer a failure".
update public.content_rungs set
  why_it_helps = 'The lesson isn''t that nothing goes wrong — it''s that when something does, you handle it and the room is fine.',
  updated_at   = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_pressure_36';

-- ── Grading: make the "Under pressure" ladder non-decreasing ────────────────
update public.content_rungs set difficulty = 8,
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_pressure_21';
update public.content_rungs set difficulty = 10,
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_pressure_35';

-- ── "Top rung" copy fix: rung 10 is no longer the top (there are 40) ────────
update public.content_rungs set
  why_it_helps = 'A real milestone — proof of how far the ladder has already carried you.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_speaking_10';
update public.content_rungs set
  why_it_helps = 'A big leap — high nerves, very survivable, and great data either way.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_approaching_10';
update public.content_rungs set
  why_it_helps = 'A milestone — you become the reason others gather.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_social_events_10';
update public.content_rungs set
  why_it_helps = 'A big step — advocating for yourself, with real stakes.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_assertiveness_10';
update public.content_rungs set
  why_it_helps = 'A milestone — fully seen, and still standing.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_visibility_10';
update public.content_rungs set
  why_it_helps = 'A big step — pressure, eyes, stakes, and you handling it.',
  updated_at = (extract(epoch from now()) * 1000)::bigint
where id = 'rng_pressure_10';

commit;
