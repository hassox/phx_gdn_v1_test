defmodule GuardianV1Test.Repo.Migrations.CreateGuardianV1Test.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :encrypted_password, :string

      timestamps()
    end

  end
end
