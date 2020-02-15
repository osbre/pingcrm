defmodule Ping.Accounts do
  alias Ping.Repo
  alias Ping.Accounts.User

  def get_user(id) do
    Repo.get(User, id)
  end
end
