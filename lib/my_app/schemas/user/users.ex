defmodule MyApp.Schemas.User.Users do
  alias MyApp.Schemas.User.User
  alias MyApp.Repo

  def create(user, params) do
    User.changeset(user, params)
    |> Repo.insert
  end

  def fetch(email) do
    Repo.get_by(User, email: email)
  end
  def fetch_by_id(user_id) do
    Repo.get(User, user_id)
  end

end
