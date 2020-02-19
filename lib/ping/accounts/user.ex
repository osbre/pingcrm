defmodule Ping.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias Ping.Accounts.Account
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :email, :first_name, :last_name, :owner, :photo]}

  @general_fields [:first_name, :last_name, :owner, :photo]

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    field :owner, :boolean
    field :photo, :string, default: "http://placekitten.com/150/150"
    belongs_to :account, Account

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, @general_fields)
    |> pow_changeset(attrs)
    |> cast_assoc(:account)
  end
end
