defmodule Ping.Accounts.UserSearch do
  @moduledoc """
  Search for users using filters.
  https://elixirschool.com/blog/ecto-query-composition/
  """
  alias Ping.Repo
  alias Ping.Accounts.User
  import Ecto.Query

  def search(criteria) do
    base_query()
    |> build_query(criteria)
    |> Repo.all()
  end

  defp base_query do
    from u in User,
      select: map(u, [:id, :email, :first_name, :last_name, :owner, account: [:name]]),
      preload: [:account]
  end

  defp build_query(query, criteria) when map_size(criteria) == 0 do
    where(query, [u], is_nil(u.trashed_at))
  end

  defp build_query(query, criteria) do
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query(%{}, query) do
    query
  end

  defp compose_query({"search", search}, query) do
    where(
      query,
      [u],
      ilike(u.first_name, ^"%#{search}%") or
        ilike(u.last_name, ^"%#{search}%") or
        ilike(u.email, ^"%#{search}%")
    )
  end

  defp compose_query({"role", "user"}, query) do
    where(query, [u], u.owner == false)
  end

  defp compose_query({"role", "owner"}, query) do
    where(query, [u], u.owner == true)
  end

  defp compose_query({"trashed", "with"}, query) do
    where(query, [u], is_nil(u.trashed_at) or not is_nil(u.trashed_at))
  end

  defp compose_query({"trashed", "only"}, query) do
    where(query, [u], not is_nil(u.trashed_at))
  end

  defp compose_query(_unsupported_param, query) do
    query
  end
end
