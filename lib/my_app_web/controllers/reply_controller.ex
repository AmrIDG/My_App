defmodule MyAppWeb.ReplyController do
  use MyAppWeb, :controller

  alias MyAppWeb.Plugs.AuthPipeline
  alias MyApp.Schemas.{Reply.Replys,Comment.Comment}


  action_fallback MyAppWeb.FallbackController

  def create(conn, %{"reply" => reply_params}) do
    parent_id = get_comment_id(conn)
    user_id = AuthPipeline.get_user_id(conn)

    params = Map.new(reply_params, fn {k, v} -> {String.to_atom(k), v} end)
    |>Map.delete([:user_id, :comment_id, :parent_id])
    reply = Replys.create_reply(user_id,parent_id, %Comment{}, params)
    render(conn, "show.json", reply: reply)
  end

  # defp get_user_id(conn) do
  #   conn
  #   |> Plug.Conn.get_req_header("user_id")
  #   |> List.first()
  #   |> String.to_integer()
  # end

  defp get_comment_id(conn) do
    conn.path_params
    |> Map.get("comment_id")
    |> String.to_integer()
  end
end
