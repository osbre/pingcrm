defmodule Ping.Users do
  alias Ping.Repo
  alias Ping.Users.User

  def get_user(id) do
    Repo.get(User, id)
  end
end
