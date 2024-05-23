defmodule MyApp.Repo.Migrations.CreatePostsTable do
  use Ecto.Migration

  def change do
    create table :posts do
      add :title, :string
      add :content, :string
      add :user_id, references(:users)

    end
    # create unique_index(:posts, [:user_id])


  end
end
