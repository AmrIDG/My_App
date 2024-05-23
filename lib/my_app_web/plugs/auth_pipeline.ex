defmodule MyAppWeb.Plugs.AuthPipeline do
  # Implement AuthPipeline
  # Define verify_token/1: Extract and verify token from headers.
  # Define unauthorized_response/1: Set :unauthorized status, respond with JSON error, and halt connection.

  alias MyAppWeb.Auth
  import Plug.Conn, only: [send_resp: 3, halt: 1]
  alias MyApp.Schemas.User.Users

  def init(opts), do: opts

  ################
  def call(conn, _opts) do
    case verify(conn) do
      {:ok, _} -> conn
      {:error, _} -> send_resp(conn, 403, "{\"error\": \"not logged in\"}")
    end
  end

  def get_user_id(conn) do
    {:ok, header} =
      conn
      |> verify
    {:ok, user_id} = Map.fetch(header, "sub")
    verify_user(user_id, conn)
    # |> IO.inspect()
  end

  defp jwt_from_cookie(conn) do
    conn
    |> Plug.Conn.get_req_header("jwt")
    |> List.first()
  end

  defp verify(conn) do
    conn
    |> jwt_from_cookie
    |> Auth.verify_token()
  end

  defp verify_user(user_id, conn) do
    user = Users.fetch_by_id(user_id)
    case user do
      nil ->
        conn
        |> send_resp(403, "{\"error\": \"user not found\"}")
        halt(conn)

      _ -> user_id
    end
  end
end
