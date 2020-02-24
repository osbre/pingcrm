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

  describe "search/2 with  multiple users" do
    test "does not include trashed", %{owner: owner, user: user} do
      result_ids =
        UserSearch.search(%{}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [owner.id, user.id]
    end

    test "displays trashed when trashed is with", context do
      result_ids =
        UserSearch.search(%{"trashed" => "with"}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [context.owner.id, context.user.id, context.trashed.id]
    end

    test "displays only trashed with trashed is only", %{trashed: trashed} do
      result_ids =
        UserSearch.search(%{"trashed" => "only"}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [trashed.id]
    end

    test "excludes current user", %{owner: owner} do
      result_ids =
        UserSearch.search(%{}, owner.id)
        |> Enum.map(fn r -> r.id end)

      refute owner.id in result_ids
    end

    test "finds user by first_name", %{user: user} do
      result_ids =
        UserSearch.search(%{"search" => user.first_name}, 0)
        |> Enum.map(fn r -> r.id end)

      assert result_ids == [user.id]
    end
  end
end
