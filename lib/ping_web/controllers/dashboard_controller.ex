defmodule PingWeb.DashboardController do
  use PingWeb, :controller

  def index(conn, _params) do
    render_inertia(conn, "Dashboard/Index")
  end
end
