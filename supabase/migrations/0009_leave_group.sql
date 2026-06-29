-- Rung — let a member leave a pod. Run AFTER 0001.
-- Security definer so it can remove the caller's own membership row regardless
-- of table RLS. A user can only ever remove THEIR OWN membership (user_id is
-- pinned to auth.uid()), never anyone else's.

create or replace function public.leave_group(gid uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.group_members
    where group_id = gid and user_id = auth.uid();
end;
$$;

grant execute on function public.leave_group(uuid) to authenticated;
