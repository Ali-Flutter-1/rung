// Rung — RevenueCat → Supabase entitlement sync (Supabase Edge Function, Deno).
//
// RevenueCat POSTs a webhook event whenever a subscription changes (purchase,
// renewal, cancellation, expiration, billing issue, refund…). This function
// verifies the shared-secret Authorization header, maps the event to our tier
// ('free' | 'monthly' | 'yearly') and writes it to profiles.subscription_tier
// for that user — so the server's pod/content limits stay correct even when the
// app is closed (renewals) and downgrades happen the moment access actually ends.
//
// The user is matched by app_user_id, which the app sets via Purchases.logIn(uid)
// (uid == the Supabase auth user id). Purchases made before logIn use an
// anonymous id and won't match — the app also re-syncs on next open as a backstop.
//
// Secrets it needs (set with: supabase secrets set ...):
//   REVENUECAT_WEBHOOK_SECRET – the Authorization header value you set in the
//                               RevenueCat dashboard webhook config
//   SUPABASE_URL              – auto-provided in Edge Functions
//   SUPABASE_SERVICE_ROLE_KEY – auto-provided in Edge Functions (bypasses RLS)
//
// Deploy: supabase functions deploy revenuecat-webhook
// Then in RevenueCat → Project → Integrations → Webhooks, point the URL at this
// function and set the Authorization header to the same REVENUECAT_WEBHOOK_SECRET.

import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

type Tier = "free" | "monthly" | "yearly";

interface RcEvent {
  type: string;
  app_user_id?: string;
  original_app_user_id?: string;
  product_id?: string;
  period_type?: string; // NORMAL | TRIAL | INTRO
  expiration_at_ms?: number | null;
}

// Product id → paid tier. Name your store products with "year"/"annual" or
// "month" so this stays robust regardless of the exact identifier.
function tierFromProduct(productId?: string): Tier {
  const p = (productId ?? "").toLowerCase();
  if (p.includes("year") || p.includes("annual")) return "yearly";
  if (p.includes("month")) return "monthly";
  return "monthly"; // active but unrecognised → assume monthly (never over-grant yearly)
}

// Event type → what to write. Grant on anything that (re)starts access; downgrade
// only when access has actually ended. CANCELLATION means auto-renew was turned
// off but the entitlement is still active until EXPIRATION — so it does NOT
// downgrade here.
function tierForEvent(e: RcEvent): Tier | null {
  switch (e.type) {
    case "INITIAL_PURCHASE":
    case "RENEWAL":
    case "UNCANCELLATION":
    case "PRODUCT_CHANGE":
    case "NON_RENEWING_PURCHASE":
    case "SUBSCRIPTION_EXTENDED":
      return tierFromProduct(e.product_id);
    case "EXPIRATION":
    case "SUBSCRIPTION_PAUSED":
      return "free";
    // TRANSFER, BILLING_ISSUE, CANCELLATION, TEST, etc. → no immediate change.
    default:
      return null;
  }
}

Deno.serve(async (req) => {
  if (req.method !== "POST") {
    return new Response("Method not allowed", { status: 405 });
  }

  // ── Verify the shared secret ──────────────────────────────────────────────
  const secret = Deno.env.get("REVENUECAT_WEBHOOK_SECRET");
  const auth = req.headers.get("Authorization") ?? "";
  if (!secret || auth !== secret) {
    return new Response("Unauthorized", { status: 401 });
  }

  let event: RcEvent;
  try {
    const body = await req.json();
    event = body.event as RcEvent;
  } catch (_) {
    return new Response("Bad request", { status: 400 });
  }
  if (!event) return new Response("No event", { status: 400 });

  const uid = event.app_user_id ?? event.original_app_user_id;
  // Anonymous ids (RevenueCat's own "$RCAnonymousID:…") never map to a profile.
  if (!uid || uid.startsWith("$RCAnonymousID")) {
    return new Response("Ignored (no mapped user)", { status: 200 });
  }

  const tier = tierForEvent(event);
  if (tier === null) {
    return new Response("Ignored (no tier change)", { status: 200 });
  }

  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );

  const { error } = await supabase
    .from("profiles")
    .update({ subscription_tier: tier, updated_at: new Date().toISOString() })
    .eq("id", uid);

  if (error) {
    console.error("[revenuecat] update failed:", error.message);
    return new Response("Update failed", { status: 500 });
  }

  return new Response(JSON.stringify({ ok: true, uid, tier }), {
    status: 200,
    headers: { "content-type": "application/json" },
  });
});
