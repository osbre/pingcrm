ExUnit.start()
Faker.start()

Application.put_env(:wallaby, :base_url, PingWeb.Endpoint.url())

{:ok, _} = Application.ensure_all_started(:wallaby)
