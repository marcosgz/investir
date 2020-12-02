defmodule Investir.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :code, :string
      add :quotation, :float
      add :ev_ebi, :float
      add :net_worth, :float
      add :net_margin, :float
      add :variation, :float

      timestamps()
    end

  end
end
