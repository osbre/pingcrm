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
        # changeset = Pow.Plug.change_user(conn, conn.params["user"])

        conn
        |> put_flash(:error, "Invalid email or password")
        |> redirect(to: Routes.login_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end

