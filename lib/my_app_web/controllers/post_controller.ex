defmodule MyAppWeb.PostController do
  use MyAppWeb, :controller

  # alias MyApp.Repo
  # alias MyApp.Schemas.User
  alias MyAppWeb.Plugs.AuthPipeline
  alias MyApp.Schemas.Post.{Post, Posts}

  action_fallback MyAppWeb.FallbackController

  def create(conn, %{"post" => post_params}) do
    user_id = AuthPipeline.get_user_id(conn)
    params = Map.new(post_params, fn {k, v} -> {String.to_atom(k), v} end)
    params = Map.delete(params, :user_id)
    post = Posts.create(user_id, %Post{}, params)
    render(conn, "show.json", post: post)
  end

  def index(conn, _params) do
    posts = Posts.retreive_posts_comments_replies()
    |> IO.inspect()
    render(conn,"index.json", posts: posts)
  end

end
