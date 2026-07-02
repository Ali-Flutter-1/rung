-- Rung — pod message reactions ("cheers"). Run AFTER 0001_init.sql.
--
-- Lets pod members react to a message with a small set of supportive emoji
-- (👏 🎉 ❤️ 💪 🌱). One row per (message, user, emoji). group_id is denormalized
-- from the message so realtime can filter by pod and RLS stays a simple
-- membership check.

create table if not exists public.message_reactions (
  message_id uuid not null references public.messages (id) on delete cascade,
  user_id    uuid not null references public.profiles (id) on delete cascade,
  emoji      text not null check (char_length(emoji) between 1 and 8),
  group_id   uuid not null references public.groups (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (message_id, user_id, emoji)
);
create index if not exists idx_reactions_message on public.message_reactions (message_id);
create index if not exists idx_reactions_group on public.message_reactions (group_id);

alter table public.message_reactions enable row level security;

-- See reactions in pods you belong to.
drop policy if exists reactions_select on public.message_reactions;
create policy reactions_select on public.message_reactions for select
  using (public.is_member(group_id));

-- React only as yourself, only in pods you belong to, and only with a group_id
-- that actually matches the message (prevents spoofing another pod's message).
drop policy if exists reactions_insert on public.message_reactions;
create policy reactions_insert on public.message_reactions for insert
  with check (
    user_id = auth.uid()
    and public.is_member(group_id)
    and exists (
      select 1 from public.messages m
      where m.id = message_id and m.group_id = message_reactions.group_id
    )
  );

-- Remove only your own reactions.
drop policy if exists reactions_delete on public.message_reactions;
create policy reactions_delete on public.message_reactions for delete
  using (user_id = auth.uid());

-- Stream reaction changes in realtime (safe to re-run; ignore "already member").
do $$
begin
  alter publication supabase_realtime add table public.message_reactions;
exception when duplicate_object then null;
end $$;
