defmodule InvestirWeb.DashboardLive do
  use InvestirWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, %{body: %{"results" => %{"stocks" => stocks}} }} = Investir.Services.HgBrasil.get("/finance")
    socket = assign(socket, :stocks, stocks)
    IO.inspect(socket)

    {:ok, socket}
  end
end