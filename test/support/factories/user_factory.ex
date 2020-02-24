defmodule Ping.UserFactory do
  alias Ping.Repo
  alias Ping.Accounts.{Account, User}
  @default_password "supersecret"

  # Convenience API
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end

  # Factories
  def build(:user) do
    %User{
      first_name: Faker.Name.first_name(),
      last_name: Faker.Name.last_name(),
      email: Faker.Internet.email(),
      password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash(@default_password),
      owner: false,
      account: build(:account),
      trashed_at: nil
    }
  end

  def build(:account) do
    %Account{name: "Test Account"}
  end

  def build(:user_map) do
    %{
      first_name: Faker.Name.first_name(),
      last_name: Faker.Name.last_name(),
      email: Faker.Internet.email(),
      password: @default_password,
      owner: false,
      account: %{name: "Account"},
      trashed_at: nil
    }
    |> Map.Helpers.stringify_keys()
  end
end
