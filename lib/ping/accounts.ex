defmodule Ping.Accounts do
  @moduledoc false
  alias Ping.Repo
  alias Ping.Accounts.{Account, User}

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id) |> Repo.preload(:account)
  end

  def get_account!(id) do
    Repo.get!(Account, id)
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

  def delete_user!(%User{} = user) do
    Repo.delete(user)
  end

  def create_account!(attrs) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end
end
