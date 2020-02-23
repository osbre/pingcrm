defmodule Ping.Accounts.UserSearchTest do
  use Ping.DataCase

  alias Ping.Accounts.{UserSearch}

  describe "users" do
    test "search/2 with valid data finds users" do
      results = UserSearch.search(%{}, 0)
      assert length(results) == 2
    end
  end
end
