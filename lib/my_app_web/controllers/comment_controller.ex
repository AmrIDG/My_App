defmodule MyAppWeb.CommentController do
  use MyAppWeb, :controller
  alias MyAppWeb.Plugs.AuthPipeline
  alias MyApp.Schemas.Comment.Comment
  alias MyApp.Schemas.Comment.Comments

  action_fallback MyAppWeb.FallbackController

  def create(conn, %{"comment" => comment_params}) do
    user_id = AuthPipeline.get_user_id(conn)
    post_id = get_post_id(conn)
    params = Map.new(comment_params, fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.delete([:user_id, :post_id])
    comment = Comments.create_comment(user_id, post_id, %Comment{}, params)
    render(conn, "show.json", comment: comment)
  end

  def index(conn, _params) do
    comments = Comments.retreive_comments()
    |> IO.inspect()
    render(conn,"index.json", comments: comments)
  end

  # defp get_user_id(conn) do
  #   conn
  #   |> Plug.Conn.get_req_header("user_id")
  #   |> List.first()
  #   |> String.to_integer()
  # end

  defp get_post_id(conn) do
    conn.path_params
    |> Map.get("post_id")
    |> String.to_integer()

  end
end
