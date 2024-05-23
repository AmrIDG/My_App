defmodule MyApp.Schemas.Reply.Replys do
  alias MyApp.Schemas.Reply.Reply
  alias MyApp.Repo


  def create_reply(user_id, parent_id, reply, params) do
    Reply.changeset(user_id, parent_id, reply, params)
    |> Repo.insert()
  end
end
