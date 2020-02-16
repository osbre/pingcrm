defmodule PingWeb.DashboardController do
  use PingWeb, :controller

  def index(conn, _params) do
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
