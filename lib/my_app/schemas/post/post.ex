defmodule MyApp.Schemas.Post.Post do

  import Ecto.Changeset
  use Ecto.Schema
  alias Hex.Repo
  alias MyApp.Schemas.{User.User,Comment.Comment}
  alias MyApp.Repo


  schema "posts" do
    field :title, :string
    field :content, :string
    has_many :comments, Comment
    belongs_to :user, User
  end

  def changeset(user_id, post, params) do
    user = Repo.get(User, user_id)
    new_post = post
    |> cast(params, [:title, :content])
    |> validate_required([:title, :content])
    |> apply_changes()
    Ecto.build_assoc(user, :posts, new_post)


  end
end
