defmodule Ping.Accounts.UserSearchTest do
  use Ping.DataCase

  alias Ping.Accounts.{UserSearch}

  defp users_for_search(_context) do
  end

  describe "when no users" do
    test "search/2 finds no users" do
      assert UserSearch.search(%{}, 0) == []
    end
  end

  describe "when multiple users" do
    setup [:users_for_search]

    test "search/2 should not display trashed" do
      assert UserSearch.search(%{}, 0) == []
    end
  end
end
