defmodule Investir.DeepValueInvesting.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :code, :string
    field :ev_ebi, :float
    field :net_margin, :float
    field :net_worth, :float
    field :quotation, :float
    field :variation, :float

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:code, :quotation, :ev_ebi, :net_worth, :net_margin, :variation])
    |> validate_required([:code, :quotation, :ev_ebi, :net_worth, :net_margin, :variation])
  end
end
