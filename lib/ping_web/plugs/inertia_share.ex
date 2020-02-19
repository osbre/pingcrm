defmodule PingWeb.Plugs.InertiaShare do
  def init(default), do: default
  alias Ping.Accounts.User

  def call(conn, _) do
    InertiaPhoenix.share(conn, :auth, build_auth_map(conn))
  end

  defp build_auth_map(conn) do
    case Pow.Plug.current_user(conn) do
      %User{} = current_user ->
        %{
          user: %{
            account: %{name: "Account"},
            first_name: "Tom",
            id: current_user.id,
            last_name: "Jones"
          }
        }
      _ -> %{}
    end
  end
end
