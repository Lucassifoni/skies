# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :skies,
  ecto_repos: [Skies.Repo]

# Configures the endpoint
config :skies, SkiesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vdu9liPzuuRxIrR3wUqy89pczDIwL18TGJEz3xauPNhTuqiUNu446Fez1lILQGdI",
  render_errors: [view: SkiesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Skies.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "/OMOGYHsaA1i6FtBSu1MBFQgPflDii+BC0zvbj2VSg2e/qKCDxpCHZFMzd2pck0A"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
