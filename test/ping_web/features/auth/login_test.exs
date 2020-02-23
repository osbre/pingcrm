defmodule PingWeb.Features.LoginTest do
  @moduledoc false
  use PingWeb.FeatureCase, async: true
  import Wallaby.Query

  test "login page has message", %{session: session} do
    session
    |> visit("/login")
    |> assert_has(css("h1", text: "Welcome Back!"))
  end
end
