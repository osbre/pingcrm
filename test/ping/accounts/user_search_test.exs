defmodule Ping.Accounts.UserSearchTest do
  use Ping.DataCase, async: true
  alias Ping.UserFactory

  alias Ping.Accounts.{UserSearch}

  setup do
    now = DateTime.utc_now() |> DateTime.truncate(:second)
    owner = UserFactory.insert!(:user, owner: true)
    user = UserFactory.insert!(:user)
    trashed = UserFactory.insert!(:user, trashed_at: now)
    {:ok, owner: owner, user: user, trashed: trashed}
  end

  describe "when multiple users" do
    test "search/2 should not display trashed", %{owner: owner, user: user} do
      result_ids =
        UserSearch.search(%{}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [owner.id, user.id]
    end

    test "search/2 should display trashed when trashed present", context do
      result_ids =
        UserSearch.search(%{"trashed" => "with"}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [context.owner.id, context.user.id, context.trashed.id]
    end

    test "search/2 should display only trashed", %{trashed: trashed} do
      result_ids =
        UserSearch.search(%{"trashed" => "only"}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [trashed.id]
    end

    test "search/2 should not include current_user", %{owner: owner} do
      result_ids =
        UserSearch.search(%{}, owner.id)
        |> Enum.map(fn r -> r.id end)

      refute owner.id in result_ids
    end
  end
end
