defmodule Investir.Finance.Overview do
  use Ecto.Schema
  import Ecto.Changeset

  alias Investir.Finance.Overview.Stock
  alias Investir.Finance.Overview.Currency
  alias Investir.Finance.Overview.Bitcoin

  schema "finance_overviews" do
    field :available_sources, {:array, :string}
    field :taxes, {:array, :map}

    embeds_many(:bitcoins, Bitcoin)
    embeds_many(:currencies, Currency)
    embeds_many(:stocks, Stock)

    timestamps()
  end

  @doc false
  def changeset(overview, attrs) do
    overview
    |> cast(attrs, [:available_sources, :taxes, :stocks, :currencies, :bitcoin])
    |> validate_required([:available_sources, :taxes, :stocks, :currencies, :bitcoin])
  end
end
