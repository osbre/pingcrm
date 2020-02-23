defmodule Ping.UserFactory do
  alias Ping.Repo
  alias Ping.Accounts.User

  # Factories
  def build(:user) do
    %{
      first_name: "test",
      last_name: "test",
      email: "test@test.com",
      password: "123123123",
      password_confirmation: "123123123",
      # password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("123123123"),
      owner: false,
      account: build(:account)
    }
  end

  def build(:account) do
    %{name: "test account"}
  end

  # Convenience API
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(:user, _attributes \\ []) do
    %User{}
    |> User.seed_changeset(build(:user))
    |> Repo.insert()
  end
end
