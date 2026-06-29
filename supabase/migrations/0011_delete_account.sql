-- Rung — permanent account & data deletion (GDPR / App Store requirement).
-- Run AFTER 0001–0010. Deleting the auth user cascades to everything that
-- references it with ON DELETE CASCADE: profiles → group_members + messages,
-- plus custom_rungs and the backup_* tables. So one delete removes all of a
-- user's data. SECURITY DEFINER so the function (owned by a privileged role)
-- may remove the auth.users row; a user can only ever delete THEMSELVES.

create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then raise exception 'not authenticated'; end if;
  delete from auth.users where id = uid;
end;
$$;

grant execute on function public.delete_my_account() to authenticated;
