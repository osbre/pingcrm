# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

Ping.Accounts.create_user!(%{
  account: %{name: "Account 1"},
  email: "johndoe@example.com",
  password: "123123123",
  password_confirmation: "123123123",
  first_name: "John",
  last_name: "Doe",
  owner: true
})

Ping.Accounts.create_user!(%{
  account: %{name: "Account 2"},
  email: "janedoe@example.com",
  password: "123123123",
  password_confirmation: "123123123",
  first_name: "Jane",
  last_name: "Doe",
  owner: true
})
