defmodule MyAppWeb.UserJSON do
  def render("show.json", %{user: user_resp}) do
    {:ok, user} = user_resp
    %{data: data(user)}
  end

  defp data(%MyApp.Schemas.User.User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
