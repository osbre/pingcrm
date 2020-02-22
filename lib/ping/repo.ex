defmodule Ping.Repo do
  use Ecto.Repo,
    otp_app: :ping,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 2
end
