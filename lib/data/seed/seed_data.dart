import '../../domain/entities/rung.dart';
import '../../domain/entities/track.dart';

/// Seeded global content (§13). Stable string ids so progress survives reinstall
/// and future cloud sync can reconcile by id (§11.5). Content is data, not UI
/// logic (§11.2): the app reads these from SQLite, never hard-codes them in
/// widgets. Re-tune ordering from real SUDS data after launch (§6 Phase 5).
class SeedData {
  const SeedData._();

  static const List<Track> tracks = [
    Track(
      id: 'trk_speaking',
      slug: 'speaking',
      title: 'Speaking up',
      description: 'Speaking & being the center of attention',
      icon: 'mic',
      sortOrder: 1,
      colorSeed: 'indigo',
    ),
    Track(
      id: 'trk_approaching',
      slug: 'approaching',
      title: 'Approaching people',
      description: 'Meeting & approaching people',
      icon: 'wave',
      sortOrder: 2,
      colorSeed: 'teal',
    ),
    Track(
      id: 'trk_social_events',
      slug: 'social_events',
      title: 'Social events',
      description: 'Group & social events',
      icon: 'groups',
      sortOrder: 3,
      colorSeed: 'violet',
    ),
    Track(
      id: 'trk_assertiveness',
      slug: 'assertiveness',
      title: 'Assertiveness',
      description: 'Conflict & assertiveness',
      icon: 'balance',
      sortOrder: 4,
      colorSeed: 'rose',
    ),
    Track(
      id: 'trk_visibility',
      slug: 'visibility',
      title: 'Being visible',
      description: 'Visibility & being judged',
      icon: 'visibility',
      sortOrder: 5,
      colorSeed: 'amber',
    ),
    Track(
      id: 'trk_pressure',
      slug: 'pressure',
      title: 'Under pressure',
      description: 'Performance under social pressure',
      icon: 'bolt',
      sortOrder: 6,
      colorSeed: 'sky',
    ),
  ];

  static const List<Rung> rungs = [
    // ── Track 1 · Speaking up ────────────────────────────────────────────
    Rung(id: 'rng_speaking_01', trackId: 'trk_speaking', difficulty: 1, sortOrder: 1, estMinutes: 2, title: 'Text a question into a group chat', whatToDo: 'Post one genuine question in a group chat you usually just read.', whyItHelps: 'Low-stakes visibility warms up the "being seen" muscle.'),
    Rung(id: 'rng_speaking_02', trackId: 'trk_speaking', difficulty: 2, sortOrder: 2, estMinutes: 2, title: 'Ask a cashier or stranger one short question', whatToDo: 'Ask someone working nearby something simple — the time, or where to find something.', whyItHelps: 'Proves a quick exchange with a stranger is survivable.'),
    Rung(id: 'rng_speaking_03', trackId: 'trk_speaking', difficulty: 3, sortOrder: 3, estMinutes: 3, title: 'Give one opinion out loud in a casual group', whatToDo: 'Share a small preference or take in a relaxed conversation.', whyItHelps: 'Your voice can take up space without anything going wrong.'),
    Rung(id: 'rng_speaking_04', trackId: 'trk_speaking', difficulty: 4, sortOrder: 4, estMinutes: 3, title: 'Ask a question in a meeting or class', whatToDo: 'Raise one clarifying question when you would normally stay quiet.', whyItHelps: 'Speaking in a structured room is practice for bigger asks.'),
    Rung(id: 'rng_speaking_05', trackId: 'trk_speaking', difficulty: 5, sortOrder: 5, estMinutes: 5, title: 'Share an update or idea unprompted in a meeting', whatToDo: 'Offer one update or idea before anyone calls on you.', whyItHelps: 'Volunteering, not just answering, builds real confidence.'),
    Rung(id: 'rng_speaking_06', trackId: 'trk_speaking', difficulty: 6, sortOrder: 6, estMinutes: 5, title: "Make a phone call you'd normally avoid", whatToDo: 'Call a shop, clinic, or service for one quick thing.', whyItHelps: 'Phone calls remove body language to lean on — good reps.'),
    Rung(id: 'rng_speaking_07', trackId: 'trk_speaking', difficulty: 7, sortOrder: 7, estMinutes: 3, title: 'Raise your hand to answer in front of a room', whatToDo: 'Answer one question with the whole room watching.', whyItHelps: 'A brief spotlight, then it passes — your prediction gets tested.'),
    Rung(id: 'rng_speaking_08', trackId: 'trk_speaking', difficulty: 8, sortOrder: 8, estMinutes: 5, title: 'Give a 2-minute explanation to a small group', whatToDo: 'Explain something you know to a few people for a couple of minutes.', whyItHelps: 'Sustained attention is a skill that gets easier with reps.'),
    Rung(id: 'rng_speaking_09', trackId: 'trk_speaking', difficulty: 9, sortOrder: 9, estMinutes: 5, title: 'Say a few words at a gathering', whatToDo: 'Propose a toast or say something warm when there is a natural moment.', whyItHelps: 'Marking a moment out loud is memorable and very doable.'),
    Rung(id: 'rng_speaking_10', trackId: 'trk_speaking', difficulty: 10, sortOrder: 10, estMinutes: 10, title: 'Give a short prepared presentation', whatToDo: 'Deliver a few prepared minutes to a group.', whyItHelps: 'A real milestone — proof of how far the ladder has already carried you.'),

    // ── Track 2 · Approaching people ─────────────────────────────────────
    Rung(id: 'rng_approaching_01', trackId: 'trk_approaching', difficulty: 1, sortOrder: 1, estMinutes: 1, title: 'Make eye contact and smile at someone', whatToDo: "Catch a stranger's eye and offer a small smile.", whyItHelps: 'A tiny signal that opening contact is safe.'),
    Rung(id: 'rng_approaching_02', trackId: 'trk_approaching', difficulty: 2, sortOrder: 2, estMinutes: 1, title: 'Greet a neighbor or coworker', whatToDo: "Offer a 'morning' or 'how's it going' you'd normally skip.", whyItHelps: 'Greetings are low-cost reps for initiating.'),
    Rung(id: 'rng_approaching_03', trackId: 'trk_approaching', difficulty: 3, sortOrder: 3, estMinutes: 2, title: 'Give someone a genuine compliment', whatToDo: 'Tell a stranger or acquaintance one true, specific compliment.', whyItHelps: 'Warm openers make approaching feel kind, not scary.'),
    Rung(id: 'rng_approaching_04', trackId: 'trk_approaching', difficulty: 4, sortOrder: 4, estMinutes: 2, title: 'Ask a stranger a small favor or question', whatToDo: 'Ask for a recommendation, directions, or a quick hand.', whyItHelps: 'People help more often than your fear predicts.'),
    Rung(id: 'rng_approaching_05', trackId: 'trk_approaching', difficulty: 5, sortOrder: 5, estMinutes: 3, title: 'Make small talk in a queue or lift', whatToDo: 'Start a light, throwaway comment with someone nearby.', whyItHelps: 'Small talk is a skill — boring topics are perfect practice.'),
    Rung(id: 'rng_approaching_06', trackId: 'trk_approaching', difficulty: 6, sortOrder: 6, estMinutes: 3, title: 'Introduce yourself to someone new', whatToDo: 'Walk up, say your name, and ask theirs.', whyItHelps: "The introduction is the hard part, and it's over in seconds."),
    Rung(id: 'rng_approaching_07', trackId: 'trk_approaching', difficulty: 7, sortOrder: 7, estMinutes: 4, title: 'Join an ongoing group conversation', whatToDo: 'Step into a group chat with a question or a point of agreement.', whyItHelps: 'Joining feels riskier than it is — they rarely mind.'),
    Rung(id: 'rng_approaching_08', trackId: 'trk_approaching', difficulty: 8, sortOrder: 8, estMinutes: 3, title: 'Swap contacts with someone you just met', whatToDo: 'If a chat goes well, suggest staying in touch.', whyItHelps: 'Turning a moment into a connection is its own brave act.'),
    Rung(id: 'rng_approaching_09', trackId: 'trk_approaching', difficulty: 9, sortOrder: 9, estMinutes: 5, title: 'Invite an acquaintance to do something', whatToDo: 'Ask someone you like-but-barely-know to a low-key plan.', whyItHelps: 'Initiating plans is how acquaintances become friends.'),
    Rung(id: 'rng_approaching_10', trackId: 'trk_approaching', difficulty: 10, sortOrder: 10, estMinutes: 5, title: 'Start a conversation with someone you find attractive', whatToDo: 'Open a friendly, no-agenda chat with someone you are drawn to.', whyItHelps: 'A big leap — high nerves, very survivable, and great data either way.'),

    // ── Track 3 · Social events ──────────────────────────────────────────
    Rung(id: 'rng_social_events_01', trackId: 'trk_social_events', difficulty: 1, sortOrder: 1, estMinutes: 1, title: 'Say yes to one invitation', whatToDo: "Accept an invite you'd usually find a reason to decline.", whyItHelps: 'Showing up is the whole battle; saying yes starts it.'),
    Rung(id: 'rng_social_events_02', trackId: 'trk_social_events', difficulty: 2, sortOrder: 2, estMinutes: 15, title: 'Walk in and stay 15 minutes', whatToDo: 'Arrive, get a drink, and give yourself a 15-minute floor.', whyItHelps: 'A small time goal makes the doorway less daunting.'),
    Rung(id: 'rng_social_events_03', trackId: 'trk_social_events', difficulty: 3, sortOrder: 3, estMinutes: 5, title: 'Stand with a group instead of hiding on your phone', whatToDo: 'Park yourself near or in a group and just be present.', whyItHelps: 'Being visibly part of things, even quietly, counts.'),
    Rung(id: 'rng_social_events_04', trackId: 'trk_social_events', difficulty: 4, sortOrder: 4, estMinutes: 3, title: 'Ask one person about themselves', whatToDo: 'Pick one person and ask something curious about them.', whyItHelps: 'Curiosity takes the spotlight off you and fills silences.'),
    Rung(id: 'rng_social_events_05', trackId: 'trk_social_events', difficulty: 5, sortOrder: 5, estMinutes: 60, title: 'Stay at an event for an hour', whatToDo: 'Set an hour goal and let yourself leave after.', whyItHelps: 'Tolerating the time builds evidence you can handle it.'),
    Rung(id: 'rng_social_events_06', trackId: 'trk_social_events', difficulty: 6, sortOrder: 6, estMinutes: 3, title: 'Introduce two people to each other', whatToDo: "Connect two people who don't know each other yet.", whyItHelps: 'Playing host gives you a role and eases self-focus.'),
    Rung(id: 'rng_social_events_07', trackId: 'trk_social_events', difficulty: 7, sortOrder: 7, estMinutes: 30, title: 'Go where you know almost no one', whatToDo: 'Attend something with mostly unfamiliar faces.', whyItHelps: 'Fewer safety blankets, bigger growth in the same loop.'),
    Rung(id: 'rng_social_events_08', trackId: 'trk_social_events', difficulty: 8, sortOrder: 8, estMinutes: 5, title: 'Share a story with a small group', whatToDo: 'Tell a short anecdote when the conversation opens up.', whyItHelps: "Holding a group's attention briefly is a real milestone."),
    Rung(id: 'rng_social_events_09', trackId: 'trk_social_events', difficulty: 9, sortOrder: 9, estMinutes: 30, title: 'Attend an event alone', whatToDo: 'Go to something on your own, with no buddy to lean on.', whyItHelps: 'Solo attendance proves you can self-rescue and stay.'),
    Rung(id: 'rng_social_events_10', trackId: 'trk_social_events', difficulty: 10, sortOrder: 10, estMinutes: 60, title: 'Host a small get-together', whatToDo: 'Invite a few people and run a simple plan.', whyItHelps: 'A milestone — you become the reason others gather.'),

    // ── Track 4 · Assertiveness ──────────────────────────────────────────
    Rung(id: 'rng_assertiveness_01', trackId: 'trk_assertiveness', difficulty: 1, sortOrder: 1, estMinutes: 1, title: 'Say "no thanks" to a small offer', whatToDo: 'Decline a free sample, an upsell, or a small offer cleanly.', whyItHelps: "A calm 'no' to something tiny rehearses bigger boundaries."),
    Rung(id: 'rng_assertiveness_02', trackId: 'trk_assertiveness', difficulty: 2, sortOrder: 2, estMinutes: 2, title: 'Ask to fix a small order mistake', whatToDo: 'Point out a wrong order and ask for it to be put right.', whyItHelps: 'You are allowed to get what you actually paid for.'),
    Rung(id: 'rng_assertiveness_03', trackId: 'trk_assertiveness', difficulty: 3, sortOrder: 3, estMinutes: 2, title: 'Express a different preference', whatToDo: "Say what you'd actually prefer instead of 'I don't mind'.", whyItHelps: 'Your preferences are valid data other people can use.'),
    Rung(id: 'rng_assertiveness_04', trackId: 'trk_assertiveness', difficulty: 4, sortOrder: 4, estMinutes: 2, title: 'Ask a friend for a small favor', whatToDo: 'Ask someone you trust for a minor bit of help.', whyItHelps: "Asking isn't a burden — it's how closeness works."),
    Rung(id: 'rng_assertiveness_05', trackId: 'trk_assertiveness', difficulty: 5, sortOrder: 5, estMinutes: 3, title: 'Politely disagree out loud', whatToDo: "Voice a different view on something that doesn't matter much.", whyItHelps: "Disagreeing kindly shows conflict needn't be a rupture."),
    Rung(id: 'rng_assertiveness_06', trackId: 'trk_assertiveness', difficulty: 6, sortOrder: 6, estMinutes: 5, title: 'Return an item or ask for a refund', whatToDo: 'Bring something back and request a refund or exchange.', whyItHelps: 'A clear, polite request usually just works.'),
    Rung(id: 'rng_assertiveness_07', trackId: 'trk_assertiveness', difficulty: 7, sortOrder: 7, estMinutes: 3, title: 'Set a boundary with someone', whatToDo: 'Decline a real request that would overextend you.', whyItHelps: 'Boundaries protect the energy you give to people you love.'),
    Rung(id: 'rng_assertiveness_08', trackId: 'trk_assertiveness', difficulty: 8, sortOrder: 8, estMinutes: 5, title: 'Give honest constructive feedback', whatToDo: 'Offer one kind, specific piece of feedback someone can use.', whyItHelps: 'Honest care, delivered gently, deepens trust.'),
    Rung(id: 'rng_assertiveness_09', trackId: 'trk_assertiveness', difficulty: 9, sortOrder: 9, estMinutes: 10, title: 'Address a recurring issue directly', whatToDo: 'Name an ongoing problem calmly with the person involved.', whyItHelps: 'Naming it once beats resenting it quietly for months.'),
    Rung(id: 'rng_assertiveness_10', trackId: 'trk_assertiveness', difficulty: 10, sortOrder: 10, estMinutes: 15, title: 'Negotiate something significant', whatToDo: 'Make a prepared case for a raise or something that matters.', whyItHelps: 'A big step — advocating for yourself, with real stakes.'),

    // ── Track 5 · Being visible ──────────────────────────────────────────
    Rung(id: 'rng_visibility_01', trackId: 'trk_visibility', difficulty: 1, sortOrder: 1, estMinutes: 2, title: 'Post something small and personal online', whatToDo: 'Share one genuine photo, thought, or update publicly.', whyItHelps: 'Being mildly visible online rehearses being seen.'),
    Rung(id: 'rng_visibility_02', trackId: 'trk_visibility', difficulty: 2, sortOrder: 2, estMinutes: 2, title: 'Wear something that draws a little attention', whatToDo: 'Wear a color, item, or style slightly bolder than usual.', whyItHelps: 'Small visible choices prove eyes on you are harmless.'),
    Rung(id: 'rng_visibility_03', trackId: 'trk_visibility', difficulty: 3, sortOrder: 3, estMinutes: 15, title: 'Eat or sit alone in a public place', whatToDo: 'Spend time solo somewhere public, unhurried.', whyItHelps: 'Nobody is watching as closely as the fear insists.'),
    Rung(id: 'rng_visibility_04', trackId: 'trk_visibility', difficulty: 4, sortOrder: 4, estMinutes: 2, title: 'Ask a question in front of others', whatToDo: 'Ask something publicly that briefly puts eyes on you.', whyItHelps: 'A short spotlight, then attention moves on.'),
    Rung(id: 'rng_visibility_05', trackId: 'trk_visibility', difficulty: 5, sortOrder: 5, estMinutes: 5, title: 'Share your work or hobby with someone', whatToDo: "Show one thing you've made or care about to a person.", whyItHelps: 'Letting people see your effort is a vulnerable, good rep.'),
    Rung(id: 'rng_visibility_06', trackId: 'trk_visibility', difficulty: 6, sortOrder: 6, estMinutes: 1, title: 'Take a compliment without deflecting', whatToDo: "Receive praise with a simple 'thank you' and nothing else.", whyItHelps: 'Letting praise land is its own form of being seen.'),
    Rung(id: 'rng_visibility_07', trackId: 'trk_visibility', difficulty: 7, sortOrder: 7, estMinutes: 3, title: 'Speak up about a mistake you made', whatToDo: 'Own a small error out loud instead of hiding it.', whyItHelps: 'Visible imperfection rarely costs what you fear.'),
    Rung(id: 'rng_visibility_08', trackId: 'trk_visibility', difficulty: 8, sortOrder: 8, estMinutes: 5, title: 'Post a video or voice note of yourself', whatToDo: 'Share something with your face or voice in it.', whyItHelps: 'Your real presence on display is a meaningful step.'),
    Rung(id: 'rng_visibility_09', trackId: 'trk_visibility', difficulty: 9, sortOrder: 9, estMinutes: 5, title: 'Share an opinion that may get pushback', whatToDo: "Say something honest that not everyone will love.", whyItHelps: 'Tolerating disagreement is freedom from needing approval.'),
    Rung(id: 'rng_visibility_10', trackId: 'trk_visibility', difficulty: 10, sortOrder: 10, estMinutes: 10, title: 'Perform or present where you are the focus', whatToDo: 'Put yourself center-stage in front of an audience.', whyItHelps: 'A milestone — fully seen, and still standing.'),

    // ── Track 6 · Under pressure ─────────────────────────────────────────
    Rung(id: 'rng_pressure_01', trackId: 'trk_pressure', difficulty: 1, sortOrder: 1, estMinutes: 1, title: 'Decide quickly while someone waits', whatToDo: 'Choose at the counter without over-apologizing for the pause.', whyItHelps: 'Small time pressure, handled, shrinks the dread of it.'),
    Rung(id: 'rng_pressure_02', trackId: 'trk_pressure', difficulty: 2, sortOrder: 2, estMinutes: 1, title: 'Answer an unexpected question on the spot', whatToDo: 'Give a real answer when caught off guard, even imperfectly.', whyItHelps: "'Good enough, right now' beats a perfect answer too late."),
    Rung(id: 'rng_pressure_03', trackId: 'trk_pressure', difficulty: 3, sortOrder: 3, estMinutes: 3, title: 'Speak while a few people watch you work', whatToDo: 'Talk through what you are doing with an audience of a few.', whyItHelps: 'Performing and explaining at once gets smoother with reps.'),
    Rung(id: 'rng_pressure_04', trackId: 'trk_pressure', difficulty: 4, sortOrder: 4, estMinutes: 3, title: 'Do a task with someone observing', whatToDo: 'Do something ordinary while someone watches, without rushing.', whyItHelps: 'Being observed is uncomfortable, not dangerous.'),
    Rung(id: 'rng_pressure_05', trackId: 'trk_pressure', difficulty: 5, sortOrder: 5, estMinutes: 5, title: 'Think out loud in front of others', whatToDo: 'Work through a problem verbally instead of going silent.', whyItHelps: 'Showing your reasoning, messy and all, builds trust.'),
    Rung(id: 'rng_pressure_06', trackId: 'trk_pressure', difficulty: 6, sortOrder: 6, estMinutes: 5, title: 'Lead a small group decision', whatToDo: 'Propose the plan and help the group choose quickly.', whyItHelps: 'Light leadership under mild pressure is a powerful rep.'),
    Rung(id: 'rng_pressure_07', trackId: 'trk_pressure', difficulty: 7, sortOrder: 7, estMinutes: 3, title: "Give an answer you're unsure about, confidently", whatToDo: 'Offer your best guess clearly, flagging it as a guess.', whyItHelps: 'Calibrated confidence is more useful than silence.'),
    Rung(id: 'rng_pressure_08', trackId: 'trk_pressure', difficulty: 8, sortOrder: 8, estMinutes: 5, title: 'Field questions after sharing something', whatToDo: 'Invite and answer a couple of questions on the spot.', whyItHelps: 'Live Q&A is unscripted pressure — and very learnable.'),
    Rung(id: 'rng_pressure_09', trackId: 'trk_pressure', difficulty: 9, sortOrder: 9, estMinutes: 5, title: 'Improvise when a plan changes last-minute', whatToDo: 'Adapt out loud when something goes off-script.', whyItHelps: 'Flexibility under pressure is a skill, not a personality.'),
    Rung(id: 'rng_pressure_10', trackId: 'trk_pressure', difficulty: 10, sortOrder: 10, estMinutes: 15, title: 'Take on a timed, watched, high-stakes task', whatToDo: 'Take on something with a clock and an audience.', whyItHelps: 'A big step — pressure, eyes, stakes, and you handling it.'),
  ];
}
