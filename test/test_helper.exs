ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Ping.Repo, :manual)

Application.put_env(:wallaby, :base_url, PingWeb.Endpoint.url())

{:ok, _} = Application.ensure_all_started(:wallaby)
