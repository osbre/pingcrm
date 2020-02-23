# defmodule PingWeb.FeatureCase do
#   use ExUnit.CaseTemplate

#   using do
#     quote do
#       use Wallaby.DSL

#       alias Ping.Repo
#       import Ecto
#       import Ecto.Changeset
#       import Ecto.Query

#       import PingWeb.Router.Helpers
#     end
#   end

#   setup tags do
#     :ok = Ecto.Adapters.SQL.Sandbox.checkout(Ping.Repo)

#     unless tags[:async] do
#       Ecto.Adapters.SQL.Sandbox.mode(Ping.Repo, {:shared, self()})
#     end

#     metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Ping.Repo, self())

#     {:ok, session} =
#       Wallaby.start_session(metadata: metadata)
#       |> IO.inspect()

#     {:ok, session: session}
#   end
# end
