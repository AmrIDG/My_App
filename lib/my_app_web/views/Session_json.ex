defmodule MyAppWeb.SessionJSON do
  def render("show.json", %{user: user_resp}) do
    {user, token} =
      user_resp
      |> IO.inspect()

    data(user, token)
  end

  defp data(user, token) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      token: token
    }
  end
end
