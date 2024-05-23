defmodule MyApp.Schemas.Comment.Comment do
  import Ecto.Changeset
  use Ecto.Schema
  alias MyApp.Schemas.{User.User,Post.Post, Comment.Comment}
  alias MyApp.Repo

  schema "comments" do

    field :content, :string
    belongs_to :post, MyApp.Schemas.Post
    belongs_to :user, User
    belongs_to :parent, Comment
    has_many :replies, Comment, foreign_key: :parent_id
  end

  def changeset(user_id, post_id, comment\\ %MyApp.Schemas.Comment.Comment{}, params) do
    user = Repo.get(User, user_id)
    post = Repo.get(Post, post_id)
    new_comment = comment
    |> cast(params, [:content])
    |> validate_required([:content])
    |> apply_changes()
    new_comment = Ecto.build_assoc(user, :comments, new_comment)
    Ecto.build_assoc(post, :comments, new_comment)

  end



end
