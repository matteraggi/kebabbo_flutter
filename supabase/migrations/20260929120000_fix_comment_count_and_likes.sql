-- Fix the post comment counter and allow liking other users' posts.
--
-- Problems fixed:
--   * the app updated posts.comments_number itself, but RLS only lets the post
--     owner update a post, so comments on other people's posts were never counted;
--   * two AFTER DELETE triggers both decremented the counter (-2 per deleted comment);
--   * likes on other people's posts are blocked by the same RLS policy.

-- 1. Comment counter: keep posts.comments_number equal to the real number of comments.
drop trigger if exists on_post_delete on public.posts;
drop trigger if exists decrement_comment_count_trigger on public.posts;

create or replace function public.sync_comment_count()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  parent_id bigint;
begin
  if tg_op = 'INSERT' then
    parent_id := new.comment;
  else
    parent_id := old.comment;
  end if;

  if parent_id is not null then
    update public.posts
    set comments_number = (select count(*) from public.posts c where c.comment = parent_id)
    where id = parent_id;
  end if;

  return null;
end;
$$;

create trigger sync_comment_count_trigger
after insert or delete on public.posts
for each row execute function public.sync_comment_count();

drop function if exists public.decrement_comment_count();

-- Backfill existing counts.
update public.posts p
set comments_number = (select count(*) from public.posts c where c.comment = p.id)
where p.comment is null
  and p.comments_number is distinct from (select count(*) from public.posts c where c.comment = p.id);

-- 2. Likes: toggle through a SECURITY DEFINER function (RLS blocks direct updates).
create or replace function public.toggle_post_like(post_id bigint)
returns uuid[]
language plpgsql
security definer
set search_path = public
as $$
declare
  uid uuid := auth.uid();
  result uuid[];
begin
  if uid is null then
    raise exception 'not authenticated';
  end if;

  update public.posts
  set "like" = case
      when uid = any(coalesce("like", '{}')) then array_remove("like", uid)
      else array_append(coalesce("like", '{}'), uid)
    end
  where id = post_id
  returning "like" into result;

  return coalesce(result, '{}');
end;
$$;

revoke all on function public.toggle_post_like(bigint) from public, anon;
grant execute on function public.toggle_post_like(bigint) to authenticated;
