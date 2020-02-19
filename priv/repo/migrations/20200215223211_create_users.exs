defmodule Ping.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:password_hash, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:owner, :boolean, default: false)
      add(:role, :string, default: "user")
      add(:photo, :string)
      add(:account_id, references(:accounts))
      add(:trashed_at, :utc_datetime)

      timestamps()
    end

    create(unique_index(:users, [:email]))
    create(index(:users, :owner))
    create(index(:users, :role))
    create(index(:users, :account_id))
  end
end
