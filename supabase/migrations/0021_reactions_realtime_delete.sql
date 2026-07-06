-- Rung — make reaction REMOVALS show up in realtime. Run AFTER 0018.
--
-- The chat streams reactions with `.eq('group_id', …)`. By default a DELETE's
-- realtime payload contains only the primary key (message_id, user_id, emoji) —
-- NOT group_id — so the delete fails the group_id filter and never reaches the
-- client. Result: you remove a reaction, add a different one, and BOTH show.
--
-- FULL replica identity sends the entire old row on DELETE (incl. group_id), so
-- the filtered stream matches it and removes the reaction.
alter table public.message_reactions replica identity full;
