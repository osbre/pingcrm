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
    user = Accounts.get_user!(user_id)

    render_inertia(conn, "Users/Edit",
      props: %{
        user: %{
          id: user.id,
          email: user.email,
          owner: user.owner,
          first_name: user.first_name,
          last_name: user.last_name,
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
    |> User.changeset(user_params)
    |> Repo.update()
    |> case do
      {:ok, user} ->
        conn
        |> put_flash(:success, "User updated successfully")
        |> redirect(to: Routes.user_path(conn, :edit, user_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        # Traverse errors to build a map:
        # https://medium.com/@cjbell_/nested-associations-changeset-errors-in-ecto-f0ce6a4fec70
        errors =
          Ecto.Changeset.traverse_errors(changeset, fn
            {msg, opts} -> String.replace(msg, "%{count}", to_string(opts[:count]))
            msg -> msg
          end)

        #         IO.puts("=> errors:")
        #         IO.inspect(errors)

        conn
        |> put_flash(:error, "Error updating user")
        |> InertiaPhoenix.share(:changeset, changeset)
        |> redirect(to: Routes.user_path(conn, :edit, user_id))
    end
  end
end
