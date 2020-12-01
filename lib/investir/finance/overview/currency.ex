defmodule Investir.Finance.Overview.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:code, :string, autogenerate: false}
  embedded_schema do
    field(:name, :string)
    field(:sell, :float)
    field(:buy, :float)
    field(:variation, :float)
  end

  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:name, :buy, :sell, :variation])
    |> validate_required([:name])
  end
end
