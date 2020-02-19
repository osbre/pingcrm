defmodule Ping.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ping.Accounts.User

  schema "accounts" do
    field :name, :string
    has_many :users, User

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
