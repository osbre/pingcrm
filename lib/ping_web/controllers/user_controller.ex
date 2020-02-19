defmodule PingWeb.UserController do
  use PingWeb, :controller
  alias Ping.Accounts

  def index(conn, params) do
    render_inertia(conn, "Users/Index",
      props: %{
        users: %{
          data: Accounts.search_users(params),
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

  def update(conn, user_params) do
  end
end
