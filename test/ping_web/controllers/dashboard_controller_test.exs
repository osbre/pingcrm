defmodule PingWeb.DashboardControllerTest do
  use PingWeb.ConnCase, async: true

  setup %{conn: conn} do
    user = Ping.UserFactory.build(:user)
    authed_conn = Pow.Plug.assign_current_user(conn, user, [])

    {:ok, conn: conn, authed_conn: authed_conn}
  end

  test "GET / not authed", %{conn: conn} do
    conn = get(conn, Routes.dashboard_path(conn, :index))
    assert html_response(conn, 302)
  end

  test "GET / authed", %{authed_conn: authed_conn} do
    conn = get(authed_conn, Routes.dashboard_path(authed_conn, :index))
    assert html_response(conn, 200)
  end
end
