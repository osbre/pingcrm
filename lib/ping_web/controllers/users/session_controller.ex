defmodule PingWeb.Users.SessionController do
  use PingWeb, :controller
  alias Ping.Users.User

  def new(conn, _params) do
    render_inertia(conn, "Auth/Login")
  end

  def create(conn, _params) do
    case Ping.Users.get_user(1) do
      %User{} = user ->
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome Back!")
        |> render_inertia("Auth/Login")
      _ ->
        conn
        |> put_flash(:error, "User not found")
        |> put_status(:see_other)
        |> redirect(to: Routes.login_path(conn, :new))
    end
  end
end
