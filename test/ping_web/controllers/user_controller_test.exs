defmodule PingWeb.UserControllerTest do
  use PingWeb.ConnCase, async: true

  @update_attrs %{first_name: "Tom"}
  @invalid_attrs %{first_name: nil}
  alias Ping.UserFactory, as: Factory

  setup %{conn: conn} do
    admin = Factory.build(:user, id: 1)
    authed_conn = Pow.Plug.assign_current_user(conn, admin, [])
    {:ok, conn: authed_conn, unauthed_conn: conn}
  end

  describe "list users" do
    test "302 when not authed", %{unauthed_conn: unauthed_conn} do
      conn = get(unauthed_conn, Routes.user_path(unauthed_conn, :index))
      assert html_response(conn, 302)
    end

    test "200 when authed", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200)
    end
  end

  describe "create user" do
    setup [:build_user]

    test "redirects when success", %{conn: conn, attrs: attrs} do
      conn = post(conn, Routes.user_path(conn, :create), attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end

    test "redirects when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :new)
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "200 when authed", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user.id))
      assert html_response(conn, 200)
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), @update_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :edit, user)
    end

    test "redirects when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :edit, user)
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "redirects to user index", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user.id))
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end
  end

  describe "restore user" do
    test "redirects to user index", %{conn: conn} do
      now = DateTime.utc_now() |> DateTime.truncate(:second)
      user = Factory.insert!(:user, trashed_at: now)
      conn = delete(conn, Routes.user_path(conn, :delete, user.id))
      assert redirected_to(conn) == Routes.user_path(conn, :index)
    end
  end

  defp create_user(_), do: {:ok, user: Factory.insert!(:user)}

  defp build_user(_) do
    data = Factory.build(:user)

    {:ok,
     attrs: %{
       account: %{name: "Account"},
       first_name: data.first_name,
       last_name: data.last_name,
       email: data.email,
       password: "supersecret"
     }}
  end
end
