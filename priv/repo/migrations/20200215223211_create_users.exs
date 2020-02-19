defmodule Ping.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string
      add :first_name, :string # Database type
      add :last_name,  :string # Elixir type which is handled by the database
      add :owner, :boolean, default: false
      add :photo, :string
      add :account_id, references(:accounts)

      timestamps()
    end
    create unique_index(:users, [:email])
    create index(:users, :owner)
    create index(:users, :account_id)
  end
end
