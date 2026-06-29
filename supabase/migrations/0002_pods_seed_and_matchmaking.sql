-- Seed discoverable pods + system-pod matchmaking.
-- Run AFTER 0001_init.sql.

-- A few public, discoverable pods (premium-sized so anyone can be shown them).
insert into public.groups (name, capacity, is_system) values
  ('Evening Owls',     50, false),
  ('First Rungs',      50, false),
  ('Phone-Call Club',  50, false)
on conflict do nothing;

-- Assign the current user to a system pod (creates/fills "Quiet Risers" pods).
-- This realizes "your first pod is system-assigned (random members)".
create or replace function public.ensure_system_pod()
returns uuid
language plpgsql security definer set search_path = public as $$
declare
  uid uuid := auth.uid();
  gid uuid;
begin
  if uid is null then raise exception 'not authenticated'; end if;

  -- Already in a system pod? Return it.
  select g.id into gid
  from group_members gm join groups g on g.id = gm.group_id
  where gm.user_id = uid and g.is_system = true
  limit 1;
  if gid is not null then return gid; end if;

  -- Find a system pod with room (capacity 25 for the starter pods).
  select g.id into gid
  from groups g
  where g.is_system = true
    and (select count(*) from group_members m where m.group_id = g.id) < g.capacity
  order by (select count(*) from group_members m where m.group_id = g.id) desc
  limit 1;

  -- None with room → create a fresh starter pod.
  if gid is null then
    insert into groups (name, capacity, is_system)
    values ('Quiet Risers', 25, true)
    returning id into gid;
  end if;

  insert into group_members (group_id, user_id)
  values (gid, uid) on conflict do nothing;
  return gid;
end;
$$;

-- Convenience: pods the current user belongs to, with live member counts.
create or replace function public.my_pods()
returns table (id uuid, name text, capacity int, is_system boolean, member_count bigint)
language sql stable security definer set search_path = public as $$
  select g.id, g.name, g.capacity, g.is_system,
         (select count(*) from group_members m where m.group_id = g.id) as member_count
  from groups g
  join group_members gm on gm.group_id = g.id
  where gm.user_id = auth.uid()
  order by g.is_system desc, g.name;
$$;

-- Convenience: discoverable pods the user is NOT yet in.
create or replace function public.discover_pods()
returns table (id uuid, name text, capacity int, member_count bigint)
language sql stable security definer set search_path = public as $$
  select g.id, g.name, g.capacity,
         (select count(*) from group_members m where m.group_id = g.id) as member_count
  from groups g
  where g.is_system = false
    and not exists (
      select 1 from group_members gm
      where gm.group_id = g.id and gm.user_id = auth.uid()
    )
  order by g.name;
$$;
