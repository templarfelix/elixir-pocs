defmodule Ledger.Control.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :account, :integer
    field :amount, :decimal
    field :org, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:account, :amount, :org])
    |> validate_required([:account, :amount, :org])
  end
end
