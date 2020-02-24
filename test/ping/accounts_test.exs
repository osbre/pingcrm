defmodule Ping.AccountsTest do
  use Ping.DataCase
  alias Ping.Accounts
  alias Ping.Accounts.User
  alias Ping.UserFactory, as: Factory

  defp build_user(_) do
    {:ok, attrs: Factory.build(:user_map)}
  end

  describe "create_user/1" do
    setup [:build_user]

    test "create_user/1 with valid data creates a user", %{attrs: attrs} do
      assert {:ok, %User{} = user} = Accounts.create_user(attrs)
      assert user.first_name == attrs["first_name"]
      assert user.last_name == attrs["last_name"]
      assert user.email == attrs["email"]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{})
    end
  end
end
