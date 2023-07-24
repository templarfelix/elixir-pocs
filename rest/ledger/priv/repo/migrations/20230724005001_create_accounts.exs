defmodule Ledger.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :account, :integer
      add :amount, :decimal
      add :org, :string

      timestamps()
    end
  end
end
