defmodule PingWeb.UserController do
  use PingWeb, :controller
  alias Ping.Accounts
  alias Ping.Accounts.{User, UserSearch}
  alias Ping.Repo
  import PingWeb.Utils

  def index(conn, params) do
    %{id: admin_id} = Pow.Plug.current_user(conn)

    page =
      UserSearch.search(params, admin_id)
      |> Repo.paginate(params)

    render_inertia(conn, "Users/Index",
      props: %{
        users: %{
          data: page.entries,
          links: pagination_links(page, "/users"),
          total: page.total_entries
        },
        filters: %{role: "", search: "", trashed: ""}
      }
    )
  end

  def new(conn, _params) do
    render_inertia(conn, "Users/Create",
      props: %{
        changeset: User.changeset(%User{}, %{}).data
      }
    )
  end

  def create(conn, user_params) do
    %User{}
    |> User.admin_changeset(user_params)
    |> Ecto.Changeset.put_assoc(:account, Accounts.get_account!(1))
    |> Repo.insert()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:success, "User successfully created")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error creating user")
        |> put_session(:errors, errors_from_changeset(changeset))
        |> redirect(to: Routes.user_path(conn, :new))
    end
  end

  def edit(conn, %{"id" => user_id}) do
    user = Accounts.get_user!(user_id)

    render_inertia(conn, "Users/Edit",
      props: %{
        user: %{
          id: user.id,
          email: user.email,
          owner: user.owner,
          first_name: user.first_name,
          last_name: user.last_name,
          trashed_at: user.trashed_at,
          account: %{
            name: user.account.name
          }
        }
      }
    )
  end

  def update(conn, %{"id" => user_id} = user_params) do
    user = Accounts.get_user!(user_id)

    user
    |> User.admin_changeset(user_params)
    |> Repo.update()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:success, "User successfully updated")
        |> redirect(to: Routes.user_path(conn, :edit, user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error updating user")
        |> put_session(:errors, errors_from_changeset(changeset))
        |> redirect(to: Routes.user_path(conn, :edit, user_id))
    end
  end

  def delete(conn, %{"id" => user_id}) do
    user = Accounts.get_user!(user_id)

    user
    |> User.admin_changeset(%{"trashed_at" => DateTime.utc_now()})
    |> Repo.update()
    |> case do
      {:ok, _user} ->
        conn
        |> put_flash(:success, "User successfully deleted")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Error deleting user")
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end

  def restore(conn, %{"user_id" => user_id}) do
    user = Accounts.get_user!(user_id)

    user
    |> User.admin_changeset(%{"trashed_at" => nil})
    |> Repo.update()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:success, "User successfully restored")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error restoring user")
        |> put_session(:errors, errors_from_changeset(changeset))
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end
end
