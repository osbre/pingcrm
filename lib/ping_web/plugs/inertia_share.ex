defmodule PingWeb.Plugs.InertiaShare do
  def init(default), do: default
  alias Ping.Accounts.User
  alias Ping.Repo
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
    case Repo.preload(Pow.Plug.current_user(conn), :account) do
      %User{} = current_user ->
        %{
          user: %{
            id: current_user.id,
            account: %{name: current_user.account.name},
            first_name: current_user.first_name,
            last_name: current_user.last_name
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
