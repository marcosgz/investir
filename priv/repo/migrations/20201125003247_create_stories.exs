defmodule Investir.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories) do
      add :headline, :string
      add :author, :string
      add :teaser, :text
      add :body, :text

      timestamps()
    end

  end
end
