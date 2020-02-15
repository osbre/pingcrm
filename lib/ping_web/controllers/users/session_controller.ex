defmodule PingWeb.Users.SessionController do
  use PingWeb, :controller

  def new(conn, _params) do
    render_inertia(conn, "Auth/Login", props: %{errors: %{}})
  end

  def create(conn, _params) do
    user = Ping.Users.get_user(1)
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> render_inertia("Auth/Login", props: %{errors: %{}})
  end
end
