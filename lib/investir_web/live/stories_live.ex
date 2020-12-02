defmodule InvestirWeb.StoriesLive do
  use InvestirWeb, :live_view

  def mount(_params, _session, socket) do
    stories = []

    socket =
      assign(socket,
        current_view: __MODULE__,
      )

    {:ok, socket, temporary_assigns: [stories: []]}
  end
end
