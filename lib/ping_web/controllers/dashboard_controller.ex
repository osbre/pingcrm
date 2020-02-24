defmodule PingWeb.DashboardController do
  use PingWeb, :controller

  def index(conn, _params) do
    render_inertia(conn, "Dashboard/Index")
  end

  def error_500(conn, _params) do
    render_inertia(conn, "Error", props: %{status: 500})
  end

  def error_404(conn, _params) do
    render_inertia(conn, "Error", props: %{status: 404})
  end
end
