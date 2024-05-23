defmodule MyApp.Repo.Migrations.CreateReplyTable do
  use Ecto.Migration

  def change do
    create table :replies do
      add :content, :string
      add :post_id, references(:posts)
      add :comment_id, references(:comments)
      add :user_id, references(:users)

    end

  end
end
