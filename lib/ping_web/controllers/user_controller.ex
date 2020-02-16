defmodule PingWeb.UserController do
  use PingWeb, :controller

  def index(conn, _params) do
    current_user = Pow.Plug.current_user(conn)
    render_inertia(conn, "Users/Index", props: %{
      auth: %{
        user: %{
          id: current_user.id,
          first_name: "Tom",
          last_name: "Jones",
          account: %{
            name: "Account"
          }
        }
      },
      users: %{
        data: [
          %{id: 1, name: "Tom", photo: "/images/phoenix.png", email: "test@test.com", owner: "me", deleted_at: "2020-02-16"}
        ],
        links: []
      },
      filters: %{role: "", search: "", trashed: ""}
    })
  end

  def show(conn, _params) do
    current_user = Pow.Plug.current_user(conn)
    render_inertia(conn, "Dashboard/Index", props: %{
      auth: %{
        user: %{
          id: current_user.id,
          first_name: "Tom",
          last_name: "Jones",
          account: %{
            name: "Account"
          }
        }
      }
    })
  end
end
