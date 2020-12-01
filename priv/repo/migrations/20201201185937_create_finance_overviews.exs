defmodule Investir.Repo.Migrations.CreateFinanceOverviews do
  use Ecto.Migration

  def change do
    create table(:finance_overviews) do
      add :available_sources, {:array, :string}
      add :taxes, {:array, :map}
      add :stocks, {:array, :map}
      add :currencies, {:array, :map}
      add :bitcoins, {:array, :map}

      timestamps()
    end
  end
end
