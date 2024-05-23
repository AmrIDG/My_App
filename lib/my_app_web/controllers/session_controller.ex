defmodule MyAppWeb.SessionController do
  use MyAppWeb, :controller
  alias MyApp.Schemas.User.Users
  alias MyAppWeb.Auth
  import Bcrypt

  def create(conn, %{"email" => email, "password" => password}) do
    # TODO: Fetch user by email using Users.get_by_email(email)
    user = Users.fetch(email)

    case user do
      nil ->
        conn
        |> send_resp(403, "{\"error\": \"user not found\"}")
        halt(conn)

      _ ->
        case check_password(user, password) do
          true ->
            token = Auth.generate_token(user)
            # TODO allow connection and pass token to connection
            conn =
              fetch_session(conn)
              |> put_session(:cookie, token)
              |> prepend_req_headers([{"jwt", token}])

            render(conn, "show.json", user: {user, token})

          _ ->
            # TODO reject connection
            # json(conn, "check credintials")
            reject_connection(conn)
        end
    end
  end

  defp check_password(user, password) do
    verify_pass(password, user.password_hash)
  end

  defp reject_connection(conn) do
    conn
    |> send_resp(403, "{\"error\": \"check credintials\"}")

    halt(conn)
  end
end
