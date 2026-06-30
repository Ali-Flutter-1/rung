// Rung — chat push notifications (Supabase Edge Function, Deno).
//
// Triggered by a Database Webhook on INSERT into public.messages. For each new
// message it pushes "<sender> sent a message" (NO message text — privacy) to the
// other pod members' devices via FCM HTTP v1, skipping the sender and anyone in
// a block relationship with the sender.
//
// Secrets it needs (set with: supabase secrets set ...):
//   FIREBASE_SERVICE_ACCOUNT  – the full Firebase service-account JSON (one line)
//   SUPABASE_URL              – auto-provided in Edge Functions
//   SUPABASE_SERVICE_ROLE_KEY – auto-provided in Edge Functions
//
// Deploy: supabase functions deploy notify-on-message
// Then add a Database Webhook (Dashboard → Database → Webhooks) on
// `messages` INSERT that POSTs to this function's URL.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

interface MessageRow {
  id: string;
  group_id: string;
  user_id: string; // sender
  body: string;
  created_at: string;
}

// ── Mint a short-lived FCM OAuth access token from the service account ───────
async function getAccessToken(sa: {
  client_email: string;
  private_key: string;
}): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const header = { alg: "RS256", typ: "JWT" };
  const claim = {
    iss: sa.client_email,
    scope: "https://www.googleapis.com/auth/firebase.messaging",
    aud: "https://oauth2.googleapis.com/token",
    iat: now,
    exp: now + 3600,
  };
  const enc = (o: unknown) =>
    btoa(JSON.stringify(o)).replace(/=/g, "").replace(/\+/g, "-").replace(/\//g, "_");
  const unsigned = `${enc(header)}.${enc(claim)}`;

  // Import the PEM private key and sign the JWT with RS256.
  const pem = sa.private_key.replace(/\\n/g, "\n");
  const der = Uint8Array.from(
    atob(pem.replace(/-----[^-]+-----/g, "").replace(/\s/g, "")),
    (c) => c.charCodeAt(0),
  );
  const key = await crypto.subtle.importKey(
    "pkcs8",
    der,
    { name: "RSASSA-PKCS1-v1_5", hash: "SHA-256" },
    false,
    ["sign"],
  );
  const sig = await crypto.subtle.sign(
    "RSASSA-PKCS1-v1_5",
    key,
    new TextEncoder().encode(unsigned),
  );
  const jwt = `${unsigned}.${
    btoa(String.fromCharCode(...new Uint8Array(sig)))
      .replace(/=/g, "").replace(/\+/g, "-").replace(/\//g, "_")
  }`;

  const res = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: `grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=${jwt}`,
  });
  const json = await res.json();
  if (!json.access_token) throw new Error("FCM token mint failed: " + JSON.stringify(json));
  return json.access_token;
}

Deno.serve(async (req) => {
  try {
    const payload = await req.json();
    const msg = payload.record as MessageRow;
    if (!msg?.group_id || !msg?.user_id) {
      return new Response("ignored", { status: 200 });
    }

    const sb = createClient(
      Deno.env.get("SUPABASE_URL")!,
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
    );

    // Pod name + sender name for the notification.
    const [{ data: group }, { data: sender }] = await Promise.all([
      sb.from("groups").select("name").eq("id", msg.group_id).single(),
      sb.from("profiles").select("display_name").eq("id", msg.user_id).single(),
    ]);

    // Recipients = pod members, minus the sender.
    const { data: members } = await sb
      .from("group_members")
      .select("user_id")
      .eq("group_id", msg.group_id)
      .neq("user_id", msg.user_id);
    let recipientIds = (members ?? []).map((m) => m.user_id as string);
    if (recipientIds.length === 0) return new Response("no recipients", { status: 200 });

    // Drop anyone in a block relationship with the sender (either direction).
    const { data: blocks } = await sb
      .from("blocks")
      .select("blocker_id, blocked_id")
      .or(`blocker_id.eq.${msg.user_id},blocked_id.eq.${msg.user_id}`);
    const blockedSet = new Set<string>();
    for (const b of blocks ?? []) {
      blockedSet.add(b.blocker_id === msg.user_id ? b.blocked_id : b.blocker_id);
    }
    recipientIds = recipientIds.filter((id) => !blockedSet.has(id));
    if (recipientIds.length === 0) return new Response("all blocked", { status: 200 });

    // Their device tokens.
    const { data: tokens } = await sb
      .from("device_tokens")
      .select("token")
      .in("user_id", recipientIds);
    const tokenList = (tokens ?? []).map((t) => t.token as string);
    if (tokenList.length === 0) return new Response("no tokens", { status: 200 });

    const sa = JSON.parse(Deno.env.get("FIREBASE_SERVICE_ACCOUNT")!);
    const accessToken = await getAccessToken(sa);
    const fcmUrl = `https://fcm.googleapis.com/v1/projects/${sa.project_id}/messages:send`;

    const title = group?.name ?? "Your pod";
    const who = sender?.display_name ?? "Someone";
    const body = `${who} sent a message`; // never the message text (privacy)

    // Send to each token; remove tokens FCM reports as stale.
    await Promise.all(tokenList.map(async (token) => {
      const res = await fetch(fcmUrl, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          message: {
            token,
            notification: { title, body },
            data: { type: "chat", groupId: msg.group_id },
            apns: { payload: { aps: { sound: "default" } } },
            android: { priority: "high" },
          },
        }),
      });
      if (res.status === 404 || res.status === 400) {
        await sb.from("device_tokens").delete().eq("token", token);
      }
    }));

    return new Response("sent", { status: 200 });
  } catch (e) {
    console.error("notify-on-message error:", e);
    return new Response("error", { status: 200 }); // never block message inserts
  }
});
