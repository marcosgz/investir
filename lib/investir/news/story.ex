defmodule Investir.News.Story do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stories" do
    field :author, :string
    field :body, :string
    field :headline, :string
    field :teaser, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:headline, :author, :teaser, :body])
    |> validate_required([:headline, :author, :teaser, :body])
  end
end
