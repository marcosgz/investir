defmodule InvestirWeb.OrganizationsLive do
  use InvestirWeb, :live_view

  alias Investir.DeepValueInvesting

  import Number.Percentage
  import Number.Currency

  def mount(_params, _session, socket) do
    organizations = DeepValueInvesting.top_organizations(10)

    socket =
      assign(socket,
        current_view: __MODULE__,
        organizations: organizations
      )

    {:ok, socket, temporary_assigns: [organizations: []]}
  end
end
