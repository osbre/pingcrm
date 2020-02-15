defmodule PingWeb.PageController do
  use PingWeb, :controller


  def index(conn, _params) do
    render_inertia(conn, "Home", props: %{hello: "world"}, extra: %{this: "thing"})
  end

  def about(conn, _params) do
    render_inertia(conn, "About", props: %{hello: "world"}, extra: %{this: "thing"})
  end
end
