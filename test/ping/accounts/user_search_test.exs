defmodule Ping.Accounts.UserSearchTest do
  use Ping.DataCase

  alias Ping.Accounts.{UserSearch}

  defp users_for_search(_context) do
    # Invoked in every block in "a block"
    {:ok, name: "John", age: 54}
  end

  describe "UserSearch no params" do
    setup [:users_for_search]

    test "search/2 with valid data finds users" do
      results = UserSearch.search(%{}, 0)
      assert length(results) == 2
    end
  end
end
