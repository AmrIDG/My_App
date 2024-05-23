defmodule MyApp.Schemas.Reply.Reply do

  import Ecto.Changeset
  use Ecto.Schema
  alias MyApp.Schemas.{User.User,Comment.Comment}
  alias MyApp.Repo

    def changeset(user_id,parent_id, reply, params) do
    user = Repo.get(User, user_id)
    parent = Repo.get(Comment, parent_id)
    new_reply = reply
    |> cast(params, [:content])
    |> validate_required([:content])
    |> apply_changes()
    new_reply = Ecto.build_assoc(user, :comments, new_reply)
    Ecto.build_assoc(parent, :replies, new_reply)
  end

end
