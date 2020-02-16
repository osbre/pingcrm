defmodule Ping.Users do
  alias Ping.Repo
  alias Ping.Users.User

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def create_user!(user_params) do
    %User{}
      |> User.changeset(user_params)
      |> Repo.insert()
  end
end
