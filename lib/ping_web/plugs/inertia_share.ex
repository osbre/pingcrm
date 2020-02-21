defmodule PingWeb.Plugs.InertiaShare do
  def init(default), do: default
  alias Ping.Accounts.User
  import Plug.Conn
  import Logger

  def call(conn, _) do
    conn =
      conn
      |> InertiaPhoenix.share(:auth, build_auth_map(conn))
      |> InertiaPhoenix.share(:errors, errors_from_session(conn))
      |> delete_session(:errors)
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

      _ ->
        %{}
    end
  end

  defp errors_from_session(conn) do
    errors = get_session(conn, :errors)

    cond do
      is_map(errors) and map_size(errors) > 0 ->
        errors

      true ->
        %{}
    end
  end
end
