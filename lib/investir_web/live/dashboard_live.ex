defmodule InvestirWeb.DashboardLive do
  use InvestirWeb, :live_view

  alias Investir.Finance

  import Number.Currency

  def mount(_params, _session, socket) do
    overview = Finance.latest_overview()

    socket =
      assign(socket,
        current_view: __MODULE__,
        overview: overview
      )

    {:ok, socket, temporary_assigns: [overview: nil]}
  end
end
