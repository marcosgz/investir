defmodule InvestirWeb.PercentageVariationComponent do
  use InvestirWeb, :live_component

  import Number.Percentage

  def mount(socket) do
    {:ok, assign(socket, amount: 0.0)}
  end

  def render(assigns) do
    ~L"""
    <span class="percentage-variation">
      <%= number_to_percentage(@amount) %>
      <%= icon(@amount) %>
    </span>
    """
  end

  defp icon(amount) do
    cond do
      amount > 0 -> raw("<i class='fas fa-arrow-up fa-color-green'></i>")
      amount < 0 -> raw("<i class='fas fa-arrow-down fa-color-red'></i>")
      true -> nil
    end
  end
end
