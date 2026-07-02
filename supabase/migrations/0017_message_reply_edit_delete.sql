-- Rung — chat: reply-to, edit, and soft-delete for messages. Run AFTER 0003.
-- Soft-delete (deleted_at) keeps the row so replies that point at it still
-- resolve; the client renders it as "message deleted". Owners may edit/delete
-- only their OWN messages (RLS). reply_to nulls out if the parent is hard-gone.

alter table public.messages
  add column if not exists reply_to uuid
    references public.messages (id) on delete set null;
alter table public.messages
  add column if not exists edited_at timestamptz;
alter table public.messages
  add column if not exists deleted_at timestamptz;

-- Edit + soft-delete both go through UPDATE, so owners need an update policy.
drop policy if exists messages_update on public.messages;
create policy messages_update on public.messages for update
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
