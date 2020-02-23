defmodule Ping.UserFactory do
  alias Ping.Repo
  alias Ping.Accounts.{Account, User}

  # Factories
  def build(:user) do
    %User{
      first_name: "test",
      last_name: "test",
      email: "test@test.com",
      password: "123123123",
      owner: "false",
      account: build(:account)
    }
  end

  def build(:account) do
    %Account{name: "test account"}
  end

  # Convenience API
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    Repo.insert!(build(factory_name, attributes))
  end
end
