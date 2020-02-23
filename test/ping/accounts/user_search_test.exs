# defmodule Ping.Accounts.UserSearchTest do
#   use Ping.DataCase

#   alias Ping.Accounts.{UserSearch}

#   defp users_for_search(_context) do
#     # Invoked in every block in "a block"
#     {:ok, name: "John", age: 54}
#   end

#   describe "UserSearch no params" do
#     setup [:users_for_search]

#     test "search/2 with valid data finds users" do
#       results = UserSearch.search(%{}, 0)
#       assert length(results) == 2
#     end
#   end
# end

# # defp my_hook(_context) do
# #   # Invoked in every block in "a block"
# #   {:ok, name: "John", age: 54}
# # end

# # describe "a block" do
# #   setup [:my_hook]

# #   test "John's age", context do
# #     assert context[:name] == "John"
# #     assert context[:age] == 54
# #   end
# # end
