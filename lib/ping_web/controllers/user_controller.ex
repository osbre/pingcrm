defmodule PingWeb.UserController do
  use PingWeb, :controller
  alias Ping.Users

  def index(conn, _params) do
    render_inertia(conn, "Users/Index", props: %{
      users: %{
        data: [
          %{id: 1, name: "Tom Jones", email: "test@test.com"}
        ],
        links: [%{active: true, label: "1", url: "/"}]
      },
      filters: %{role: "", search: "", trashed: ""}
    })
  end

  def show(conn, _params) do
    # render_inertia(conn, "Dashboard/Index")
  end

  def edit(conn, %{"id" => user_id}) do
    user = Users.get(user_id)
    render_inertia(conn, "Users/Edit", props: %{
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
    })
  end

  def update(conn, user_params) do

  end
end
