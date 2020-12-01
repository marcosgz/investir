defmodule Investir.Finance.Overview.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:code, :string, autogenerate: false}
  embedded_schema do
    field(:location, :string)
    field(:name, :string)
    field(:points, :float)
    field(:variation, :float)
  end

  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:location, :name, :points, :variation])
    |> validate_required([:name])
  end
end
