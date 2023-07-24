defmodule Ledger.ControlFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ledger.Control` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        pk: "7488a646-e31f-11e4-aace-600308960662",
        account: 42,
        amount: "120.5",
        org: "some org"
      })
      |> Ledger.Control.create_account()

    account
  end

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        account: 42,
        amount: "120.5",
        org: "some org"
      })
      |> Ledger.Control.create_account()

    account
  end
end
