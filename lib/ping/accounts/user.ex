defmodule Ping.Accounts.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias Ping.Accounts.Account
  import Ecto.Changeset

  @general_fields [:first_name, :last_name, :owner, :photo, :trashed_at]

  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    field :owner, :boolean
    field :photo, :string, default: "http://placekitten.com/150/150"
    field :trashed_at, :utc_datetime
    belongs_to :account, Account

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, @general_fields)
    |> validate_required([:first_name, :last_name])
    |> cast_assoc(:account)
    |> pow_changeset(attrs)
    |> maybe_validate_current_password(attrs)
    |> pow_password_changeset(attrs)
  end

  defp maybe_validate_current_password(user_or_changeset, attrs) do
    case current_password_entered?(attrs) do
      false -> user_or_changeset
      true -> pow_current_password_changeset(user_or_changeset, attrs)
    end
  end

  defp current_password_entered?(%{"current_password" => _}), do: true
  defp current_password_entered?(_), do: false
end
