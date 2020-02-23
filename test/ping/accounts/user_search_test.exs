defmodule Ping.Accounts.UserSearchTest do
  use Ping.DataCase

  alias Ping.Accounts.{UserSearch}

  defp users_for_search(_context) do
    :ok
  end

  describe "UserSearch no params" do
    setup [:users_for_search]

    test "search/2 with valid data finds users" do
      assert UserSearch.search(%{}, 0) == []
    end
  end
end
