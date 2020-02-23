# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs

alias Ping.Accounts
alias Ping.Accounts.User
alias Ping.Repo

{:ok, account} = Accounts.create_account!(%{name: "Account 1"})

users_data = [
  %{
    account: account,
    email: "johndoe@example.com",
    password: "123123123",
    password_confirmation: "123123123",
    first_name: "John",
    last_name: "Doe",
    owner: true,
    role: "admin"
  },
  %{
    account: account,
    email: "janedoe@example.com",
    password: "123123123",
    password_confirmation: "123123123",
    first_name: "Jane",
    last_name: "Doe",
    owner: false
  },
  %{
    account: account,
    email: "trashed@example.com",
    password: "123123123",
    password_confirmation: "123123123",
    first_name: "Tom",
    last_name: "Trash",
    trashed_at: DateTime.utc_now(),
    owner: false
  }
]

for user_attrs <- users_data do
  %User{}
  |> User.seed_changeset(user_attrs)
  |> Repo.insert()
end
