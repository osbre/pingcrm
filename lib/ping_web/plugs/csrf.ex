defmodule PhxroadWeb.Plugs.CSRF do
  import Plug.Conn, only: [halt: 1]

  alias PhxroadWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug

  def init(config), do: config

  def call(conn, _) do
    conn
    |> Conn.put_resp_cookie("XSRF-TOKEN", Conn.get_csrf_token())
  end
end
