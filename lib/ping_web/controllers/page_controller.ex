defmodule PingWeb.PageController do
  use PingWeb, :controller

  def login(conn, _params) do
    render_inertia(conn, "Auth/Login", props: %{errors: %{}})
  end
end
