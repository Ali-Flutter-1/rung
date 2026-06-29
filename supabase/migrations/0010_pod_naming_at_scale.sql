-- Rung — scalable pod naming + keep pods topped up. Run AFTER 0002.
-- Problem this solves: every auto-created pod was named "Quiet Risers", so at
-- scale you'd have hundreds of identical names. Now each new pod gets a calm,
-- varied two-word name (e.g. "Gentle Owls", "Brave Harbor"), with a number
-- suffix only once the word-pool combinations are exhausted.

create sequence if not exists public.pod_name_seq;

-- 24 × 24 = 576 unique combinations before any number is appended.
create or replace function public.gen_pod_name(seq bigint)
returns text language plpgsql immutable as $$
declare
  adj  text[] := array['Quiet','Gentle','Brave','Calm','Warm','Kind','Steady',
                       'Bright','Soft','Open','Easy','Patient','Hopeful','Curious',
                       'Rising','Settling','Still','Glad','Clear','Mellow','Tender',
                       'Sunny','Cosy','Earnest'];
  noun text[] := array['Risers','Owls','Harbor','Embers','Steps','Sparrows',
                       'Lanterns','Currents','Meadows','Pines','Tides','Glades',
                       'Hearths','Trails','Willows','Breezes','Brooks','Dawns',
                       'Havens','Circles','Groves','Shores','Nests','Sparks'];
  na    int := array_length(adj, 1);
  nn    int := array_length(noun, 1);
  total int := na * nn;
  base  text;
begin
  base := adj[1 + ((seq / nn) % na)::int] || ' ' || noun[1 + (seq % nn)::int];
  if seq >= total then
    base := base || ' ' || (1 + (seq / total))::text; -- e.g. "Gentle Owls 2"
  end if;
  return base;
end;
$$;

-- Starter-pod matchmaking now creates uniquely-named pods.
create or replace function public.ensure_system_pod()
returns uuid
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  gid uuid;
begin
  if uid is null then raise exception 'not authenticated'; end if;

  select g.id into gid
  from group_members gm join groups g on g.id = gm.group_id
  where gm.user_id = uid and g.is_system = true
  limit 1;
  if gid is not null then return gid; end if;

  -- Fullest starter pod that still has room (lands new people WITH others).
  select g.id into gid
  from groups g
  where g.is_system = true
    and (select count(*) from group_members m where m.group_id = g.id) < g.capacity
  order by (select count(*) from group_members m where m.group_id = g.id) desc
  limit 1;

  if gid is null then
    insert into groups (name, capacity, is_system)
    values (gen_pod_name(nextval('pod_name_seq')), 25, true)
    returning id into gid;
  end if;

  insert into group_members (group_id, user_id)
  values (gid, uid) on conflict do nothing;
  return gid;
end;
$$;

-- Matchmaking for "Join another pod": returns the fullest joinable discoverable
-- pod, creating a fresh uniquely-named one when none has room. Tier/capacity are
-- still enforced by join_group when the client actually joins the returned id.
create or replace function public.match_discover_pod()
returns uuid
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  gid uuid;
begin
  if uid is null then raise exception 'not authenticated'; end if;

  select g.id into gid
  from groups g
  where g.is_system = false
    and (select count(*) from group_members m where m.group_id = g.id) < g.capacity
    and not exists (select 1 from group_members gm
                    where gm.group_id = g.id and gm.user_id = uid)
  order by (select count(*) from group_members m where m.group_id = g.id) desc
  limit 1;

  if gid is null then
    insert into groups (name, capacity, is_system)
    values (gen_pod_name(nextval('pod_name_seq')), 50, false)
    returning id into gid;
  end if;
  return gid;
end;
$$;

grant execute on function public.match_discover_pod() to authenticated;
