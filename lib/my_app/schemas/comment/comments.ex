defmodule MyApp.Schemas.Comment.Comments do

  alias MyApp.Repo
  alias MyApp.Schemas.Comment.Comment
  import Ecto.Query

  def create_comment(user_id, post_id, comment, params) do
    Comment.changeset(user_id, post_id, comment, params)
    |>Repo.insert()
  end



  def retreive_comments() do
    Comment
    |> join(:left, [c], assoc(c, :replies), as: :replies)
    |> preload(:replies)
  #   from(p in Comment,
  #   join: r in Comment, as: :replies, on: r.parent_id == p.id, preload: :replies)
  |> Repo.all()
  end

  def get_comment_with_replies(comment_id) do
    Comment
    |> where(id: ^comment_id)
    |> preload(:replies)
    |> Repo.one
  end

end
