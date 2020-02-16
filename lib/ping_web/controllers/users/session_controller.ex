defmodule PingWeb.Users.SessionController do
  use PingWeb, :controller
  alias Ping.Users.User

  def new(conn, _params) do
    render_inertia(conn, "Auth/Login")
  end

  def create(conn, params) do
    conn
    |> Pow.Plug.authenticate_user(params)
    |> case do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.dashboard_path(conn, :index))
      {:error, conn} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> redirect(to: Routes.login_path(conn, :new))
    end
  end

  # https://hexdocs.pm/plug/Plug.Conn.Status.html
  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> put_status(:see_other)
    |> redirect(to: Routes.login_path(conn, :new))
  end
end

