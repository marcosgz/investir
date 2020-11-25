defmodule Investir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Investir.Repo,
      # Start the Telemetry supervisor
      InvestirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Investir.PubSub},
      # Start the Endpoint (http/https)
      InvestirWeb.Endpoint,
      Investir.Services.HgBrasil.child_spec()
      # Start a worker by calling: Investir.Worker.start_link(arg)
      # {Investir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Investir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    InvestirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
