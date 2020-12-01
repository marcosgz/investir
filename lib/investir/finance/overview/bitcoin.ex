defmodule Investir.Finance.Overview.Bitcoin do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:code, :string, autogenerate: false}
  embedded_schema do
    field :name, :string
    field :format, {:array, :string}
    field :buy, :float
    field :sell, :float
    field :variation, :float
  end

  def changeset(bitcoin, attrs) do
    bitcoin
    |> cast(attrs, [:name, :format, :buy, :sell, :variation])
    |> validate_required([:name])
  end
end
