defmodule MyApp.Schemas.User.User do

  import Ecto.Changeset
  use Ecto.Schema
  import Bcrypt
  alias MyApp.Schemas.{Comment.Comment, Post.Post}

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :comments, Comment
    has_many :posts, Post
    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    if changeset.valid? do
      hash = changeset.changes.password
      |> hash_pwd_salt()
      changeset
      |> change(%{password_hash: hash})
      # TODO: Implement password hashing using :crypto
    else
      changeset
    end
  end
end
