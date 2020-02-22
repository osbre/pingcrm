# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ping,
  ecto_repos: [Ping.Repo]

config :ping, Ping.Repo, migration_timestamps: [type: :utc_datetime]

# Configures the endpoint
config :ping, PingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SUA9NP6lRe1hfo7Fh24QDiwMHLsMXDlkii9irrrkZn8vkQccHVWzPsR0D73E3TWm",
  render_errors: [view: PingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ping.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :ping, :pow,
  user: Ping.Accounts.User,
  repo: Ping.Repo

config :inertia_phoenix,
  assets_version: 1,
  inertia_layout: "app.html"

config :upload, Upload.Adapters.Local,
  storage_path: "priv/static/uploads",
  public_path: "/uploads"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
