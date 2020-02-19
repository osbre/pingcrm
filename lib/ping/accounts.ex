defmodule Ping.Accounts do
  alias Ping.Repo
  alias Ping.Accounts.User
  import Ecto.Query, only: [from: 2]

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def list_users do
    Repo.all(User)
  end

  def create_user!(user_attrs) do
    %User{}
    |> User.changeset(user_attrs)
    |> Repo.insert()
  end
end
