// Rung — AI Coach (Supabase Edge Function, Deno).
//
// A warm "rehearse / debrief" companion for social anxiety. The Groq API key
// NEVER leaves the server. The function verifies the caller's JWT, checks they
// are Premium, enforces a daily message cap, runs a crisis backstop, then calls
// Groq (OpenAI-compatible chat completions) and returns the reply text.
//
// Secrets (set with: supabase secrets set ...):
//   GROQ_API_KEY               – your Groq API key (gsk_…)
//   SUPABASE_URL               – auto-provided in Edge Functions
//   SUPABASE_SERVICE_ROLE_KEY  – auto-provided in Edge Functions
//
// Deploy: supabase functions deploy coach

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const GROQ_URL = "https://api.groq.com/openai/v1/chat/completions";
const MODEL = "llama-3.3-70b-versatile"; // swap here to change models
const DAILY_CAP = 40; // messages per Premium user per day (cost guardrail)
const MAX_HISTORY = 12; // trailing turns sent to the model (token guardrail)

// Server-side crisis backstop — mirrors the client's ContentGuard so we never
// "coach" someone in crisis even if the client check is bypassed.
const CRISIS = new RegExp(
  "kill myself|killing myself|end my life|want to die|wanna die|" +
    "suicid|self[\\s-]?harm|hurt myself|cut myself|no reason to live|" +
    "can'?t go on|better off dead",
  "i",
);

function systemPrompt(mode: string, context?: string): string {
  const base = `You are the Rung Coach — a warm, steady companion inside Rung, an app that helps people with social anxiety take small, brave steps.

WHO YOU ARE
- Supportive, calm, human. You talk like a kind friend who understands anxiety — not a clinician, not a hype machine.
- Keep replies SHORT: 2–5 sentences, sometimes one. This is a chat, not an essay. Never lecture.
- You are NOT a therapist and never diagnose. If asked, say you're a supportive coach, not a substitute for professional help.

HOW YOU HELP
- Validate the feeling first, briefly, then help them move.
- Be concrete: offer small, doable next actions or the exact words they could say — never vague "just be confident".
- Match their pace. Never push someone past what they're ready for. A smaller step, or resting, is always valid.
- Celebrate effort, not just outcomes. Showing up nervous IS the win.

TONE
- Gentle, plain language. No jargon, no toxic positivity, no exclamation spam.
- Never shame avoidance. Leaving early or saying no is not failure.
- No medical advice. No moralising.

SAFETY (most important)
- If the person mentions suicide, self-harm, or being in danger: STOP coaching. Reply with brief warmth, tell them they deserve support right now, and gently encourage them to contact a crisis line or someone they trust. Do NOT problem-solve or role-play. Keep it short and caring.
- Never encourage risky, harmful, illegal, or self-destructive behaviour, even in "rehearsal".

FORMAT
- Plain text, like a text message. No markdown headers. Bullet points only when giving 2–3 short options.`;

  const modeBlock = mode === "debrief"
    ? `

MODE: DEBRIEF
They just did something hard, or it didn't go how they hoped. Help them process:
- First name what they DID — they showed up, that counts.
- Gently challenge harsh self-judgement and catastrophising with a kinder, more accurate view.
- Point out one thing that actually went okay, and one small thing to carry forward.
Warmth first. Never pile on.`
    : `

MODE: REHEARSE
They have a situation coming up they're anxious about. Help them prepare:
- If you're missing key details, ask ONE gentle question (who / where / what they fear).
- Then offer a small plan: a couple of things they could say or do, plus one grounding reminder.
- You may offer to role-play a line or two so they can practise a reply.
Keep it light and doable.`;

  const ctx = context && context.trim().length > 0
    ? `\n\nABOUT THIS PERSON (use gently, don't recite): ${context.trim()}`
    : "";

  return base + modeBlock + ctx;
}

Deno.serve(async (req) => {
  try {
    if (req.method !== "POST") return json({ error: "method" }, 405);

    const groqKey = Deno.env.get("GROQ_API_KEY");
    if (!groqKey) return json({ error: "coach_unconfigured" }, 200);

    // ── Verify the caller ────────────────────────────────────────────────
    const jwt = (req.headers.get("Authorization") ?? "").replace("Bearer ", "");
    if (!jwt) return json({ error: "unauthorized" }, 401);
    const admin = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );
    const { data: { user } } = await admin.auth.getUser(jwt);
    if (!user) return json({ error: "unauthorized" }, 401);
    const uid = user.id;

    // ── Premium gate (server-side, defence in depth) ─────────────────────
    const { data: profile } = await admin
      .from("profiles")
      .select("subscription_tier")
      .eq("id", uid)
      .single();
    if (!profile || profile.subscription_tier === "free") {
      return json({ error: "premium_required" }, 200);
    }

    const payload = await req.json();
    const mode = payload.mode === "debrief" ? "debrief" : "rehearse";
    const context = typeof payload.context === "string" ? payload.context : undefined;
    const history = Array.isArray(payload.messages) ? payload.messages : [];

    // ── Crisis backstop ──────────────────────────────────────────────────
    const lastUser = [...history].reverse().find((m) => m?.role === "user");
    if (lastUser && CRISIS.test(String(lastUser.content ?? ""))) {
      return json({ crisis: true }, 200);
    }

    // ── Daily cap (cost guardrail) ───────────────────────────────────────
    const { data: count } = await admin.rpc("bump_coach_usage", { p_uid: uid });
    if (typeof count === "number" && count > DAILY_CAP) {
      return json({ error: "daily_limit" }, 200);
    }

    // ── Build the message list for Groq ──────────────────────────────────
    const trimmed = history.slice(-MAX_HISTORY).map((m) => ({
      role: m.role === "assistant" ? "assistant" : "user",
      content: String(m.content ?? "").slice(0, 2000),
    }));
    const messages = [
      { role: "system", content: systemPrompt(mode, context) },
      ...trimmed,
    ];

    const res = await fetch(GROQ_URL, {
      method: "POST",
      headers: {
        Authorization: `Bearer ${groqKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: MODEL,
        messages,
        temperature: 0.7,
        max_tokens: 400,
      }),
    });
    if (!res.ok) {
      console.error("groq error", res.status, await res.text());
      return json({ error: "coach_unavailable" }, 200);
    }
    const data = await res.json();
    const reply = data?.choices?.[0]?.message?.content?.trim();
    if (!reply) return json({ error: "coach_unavailable" }, 200);

    return json({ reply }, 200);
  } catch (e) {
    console.error("coach error:", e);
    return json({ error: "coach_unavailable" }, 200);
  }
});

function json(body: unknown, status: number): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}
