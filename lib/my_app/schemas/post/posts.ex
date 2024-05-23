defmodule MyApp.Schemas.Post.Posts do

  use Ecto.Schema
  alias MyApp.Schemas.Post.Post
  alias Hex.Repo
  alias MyApp.Schemas.Comment.Comment
  alias MyApp.Repo
  import Ecto.Query

  def create(user_id, post, params) do
    Post.changeset(user_id, post, params)
    |>Repo.insert()

  end

  def retreive_posts_comments_replies() do
    Repo.all from post in Post,
    left_join: comments in assoc(post, :comments),
    left_join: replies in assoc(comments, :replies),
    preload: [comments: {comments, replies: ^(from r in Comment, where: is_nil(r.post_id) )}]

  end

end
