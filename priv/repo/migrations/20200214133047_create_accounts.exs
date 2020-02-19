defmodule Ping.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add(:name, :string)
      add(:trashed_at, :utc_datetime)

      timestamps()
    end
  end
end
