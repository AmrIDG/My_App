# defmodule MyApp.Schemas.Reply do
#   import Ecto.Changeset
#   use Ecto.Schema
#   # import Bcrypt
#   alias Hex.Repo
#   alias MyApp.Schemas.{User,Comment}
#   alias MyApp.Repo

#   schema "replies" do
#     field :content, :string
#     belongs_to :comment, MyApp.Schemas.Comment
#     belongs_to :post, MyApp.Schemas.Post
#     belongs_to :user, MyApp.Schemas.User
#   end
#   def changeset(user_id,comment_id, reply, params) do
#     user = Repo.get(User, user_id)
#     # post = Repo.get(Post, post_id)
#     comment = Repo.get(Comment, comment_id)

#     new_reply = reply
#     |> cast(params, [:content])
#     |> validate_required([:content])
#     |> apply_changes()
#     new_reply = Ecto.build_assoc(user, :replies, new_reply)
#     # new_reply = Ecto.build_assoc(post, :replies, new_reply)
#     Ecto.build_assoc(comment, :replies, new_reply)
#     |>Repo.insert()
#   end


# end
