defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller

  alias MyApp.Repo
  alias MyApp.Schemas.User.Users
  alias MyApp.Schemas.User.User


  action_fallback MyAppWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    params = Map.new(user_params,fn {k, v} -> {String.to_atom(k), v} end)
    # |> IO.puts()

    user = Users.create(%User{}, params)
    render(conn, "show.json", user: user)
  end

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.json", user: user)
  end


end
