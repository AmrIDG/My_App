defmodule MyApp.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table :comments do
      add :content, :string
      add :post_id, references(:posts)
      add :user_id, references(:users)
      add :parent_id, references(:comments, on_delete: :nothing)


    end
    create index(:comments, [:parent_id])

  end
end
