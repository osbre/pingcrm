defmodule PingWeb.Users.SessionController do
  use PingWeb, :controller
  alias Ping.Users.User

  def new(conn, _params) do
    render_inertia(conn, "Auth/Login", props: %{errors: %{}})
  end

  def create(conn, _params) do
    case Ping.Users.get_user(1) do
      %User{} = user ->
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome Back!")
        |> render_inertia("Auth/Login", props: %{errors: %{}})
      _ ->
        conn
        |> put_flash(:info, "User data not found")
        |> redirect(to: "/login") |> halt()
    end
  end
end
