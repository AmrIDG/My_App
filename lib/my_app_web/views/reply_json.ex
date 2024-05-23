defmodule MyAppWeb.ReplyJSON do
  alias MyApp.Schemas.Comment.Comment
  def render("show.json", %{reply: reply_resp}) do
    {:ok, reply} = reply_resp
    %{reply: data(reply)}
  end

  defp data(%Comment{} = reply) do
    %{
      reply_id: reply.id,
      user_id: reply.user_id,
      comment_id: reply.parent_id,
      content: reply.content
    }
  end
end
