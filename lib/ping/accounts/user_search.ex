defmodule Ping.Accounts.UserSearch do
  alias Ping.Repo
  alias Ping.Accounts.User
  import Ecto.Query, only: [from: 2]
  import Ecto.Query

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({"title", title}, query) do
    where(query, [p], ilike(p.title, ^"%#{title}%"))
  end

  defp compose_query({"tags", tags}, query) do
    query
    |> join(:left, [p], t in assoc(p, :tags))
    |> where([_p, t], t.name in ^tags)
  end

  defp compose_query({key, value}, query) when key in ~w(draft id) do
    where(query, [p], ^{String.to_atom(key), value})
  end

  defp compose_query(_unsupported_param, query) do
    query
  end

  def search(params \\ %{})

  def search(params) when map_size(params) == 0 do
    query =
      from u in User,
        select: map(u, [:id, :email, :first_name, :last_name, :owner, account: [:name]]),
        preload: [:account]

    Repo.all(query)
  end

  defp base_query do
    from(u in User)
  end
end
