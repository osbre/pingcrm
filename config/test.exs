use Mix.Config

# Configure your database
config :ping, Ping.Repo,
  username: "postgres",
  password: "postgres",
  database: "ping_test",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :ping, Ping.Repo,
    username: "postgres",
    password: "postgres"
end

config :logger, level: :warn

config :ping, PingWeb.Endpoint,
  http: [port: 4002],
  server: true

# wallaby
config :ping, :sql_sandbox, true

config :wallaby,
  driver: Wallaby.Experimental.Chrome,
  chrome: [headless: true]
