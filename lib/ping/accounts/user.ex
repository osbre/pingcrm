defmodule Ping.Accounts.User do
  @moduledoc false
  use Ecto.Schema
  use Pow.Ecto.Schema
  alias Ping.Accounts.Account
  import Ecto.Changeset

  @general_fields [
    :first_name,
    :last_name,
    :owner,
    :trashed_at,
    :password,
    :current_password
  ]
  @derived [
    :id,
    :email,
    :first_name,
    :last_name,
    :owner,
    :photo,
    :trashed_at
  ]

  @derive {Jason.Encoder, only: @derived}
  schema "users" do
    pow_user_fields()
    field :first_name, :string
    field :last_name, :string
    field :owner, :boolean
    field :photo, :string, default: "photos/user.jpg"
    field :trashed_at, :utc_datetime
    belongs_to :account, Account

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    attrs = put_password_confirmation(attrs)

    user_or_changeset
    |> cast(attrs, @general_fields)
    |> validate_required([:first_name, :last_name])
    |> cast_assoc(:account)
    |> pow_changeset(attrs)
    |> pow_password_changeset(attrs)
  end

  def admin_changeset(struct, attrs) do
    attrs = put_password_confirmation(attrs)

    struct
    |> cast(attrs, @general_fields)
    |> Upload.Ecto.cast_upload(:photo, prefix: ["photos"])
    |> validate_required([:first_name, :last_name])
    |> cast_assoc(:account)
    |> pow_user_id_field_changeset(attrs)
    |> pow_password_changeset(attrs)
  end

  def seed_changeset(user_or_changeset, attrs) do
    attrs = put_password_confirmation(attrs)

    user_or_changeset
    |> cast(attrs, @general_fields)
    |> validate_required([:first_name, :last_name])
    |> put_assoc(:account, attrs.account)
    |> pow_changeset(attrs)
    |> pow_password_changeset(attrs)
  end

  defp put_password_confirmation(attrs) do
    case has_password_confirmation?(attrs) do
      true -> attrs
      false -> Map.put(attrs, "password_confirmation", attrs["password"])
    end
  end

  defp has_password_confirmation?(%{"password_confirmation" => password_confirmation})
       when is_binary(password_confirmation) and password_confirmation != "",
       do: true

  defp has_password_confirmation?(%{password_confirmation: password_confirmation})
       when is_binary(password_confirmation) and password_confirmation != "",
       do: true

  defp has_password_confirmation?(_attrs), do: false
end
