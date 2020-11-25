# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :investir,
  ecto_repos: [Investir.Repo]

# Configures the endpoint
config :investir, InvestirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5msl4EOgD0TNxVFzeBYpeqyFhLMUdTYDTeG6sgTsERlDLvdejV63IWZkGR0ebWuZ",
  render_errors: [view: InvestirWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Investir.PubSub,
  live_view: [signing_salt: "cv2JzUvi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :investir, Investir.Services.HgBrasil,
  url: "https://api.hgbrasil.com",
  headers: []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
