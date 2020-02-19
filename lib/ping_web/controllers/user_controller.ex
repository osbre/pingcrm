defmodule PingWeb.UserController do
  use PingWeb, :controller
  alias Ping.Accounts
  alias Ping.Accounts.{User, UserSearch}
  alias Ping.Repo

  def index(conn, params) do
    render_inertia(conn, "Users/Index",
      props: %{
        users: %{
          data: UserSearch.search(params),
          links: [%{active: true, label: "1", url: "/"}]
        },
        filters: %{role: "", search: "", trashed: ""}
      }
    )
  end

  def show(conn, _params) do
    # render_inertia(conn, "Dashboard/Index")
  end

  def edit(conn, %{"id" => user_id}) do
    user = Accounts.get_user(user_id)

    render_inertia(conn, "Users/Edit",
      props: %{
        user: %{
          id: user.id,
          email: user.email,
          owner: true,
          first_name: "Tom",
          last_name: "Jones",
          account: %{
            name: "Account"
          }
        },
        errors: []
      }
    )
  end

  def update(conn, %{"id" => user_id} = user_params) do
    IO.inspect(user_params)
    user = Accounts.get_user!(user_id)

    user
    |> User.changeset(user_params)
    |> Repo.update()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:success, "User updated successfully")
        |> redirect(to: Routes.user_path(conn, :edit, user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error updating user")
        |> assign(:errors, changeset.errors)
        |> redirect(to: Routes.user_path(conn, :edit, user_id))
    end

    # |> Pow.Plug.authenticate_user(params)
    # |> case do
    #   {:ok, conn} ->
    #     conn
    #     |> put_flash(:info, "Welcome back!")
    #     |> redirect(to: Routes.dashboard_path(conn, :index))
    #   {:error, conn} ->
    #     conn
    #     |> put_flash(:error, "Invalid email or password")
    #     |> redirect(to: Routes.login_path(conn, :new))
    # end
  end
end
