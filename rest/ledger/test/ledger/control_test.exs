defmodule Ledger.ControlTest do
  use Ledger.DataCase

  alias Ledger.Control

  describe "accounts" do
    alias Ledger.Control.Account

    import Ledger.ControlFixtures

    @invalid_attrs %{pk: nil, account: nil, amount: nil, org: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Control.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Control.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{pk: "7488a646-e31f-11e4-aace-600308960662", account: 42, amount: "120.5", org: "some org"}

      assert {:ok, %Account{} = account} = Control.create_account(valid_attrs)
      assert account.pk == "7488a646-e31f-11e4-aace-600308960662"
      assert account.account == 42
      assert account.amount == Decimal.new("120.5")
      assert account.org == "some org"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Control.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{pk: "7488a646-e31f-11e4-aace-600308960668", account: 43, amount: "456.7", org: "some updated org"}

      assert {:ok, %Account{} = account} = Control.update_account(account, update_attrs)
      assert account.pk == "7488a646-e31f-11e4-aace-600308960668"
      assert account.account == 43
      assert account.amount == Decimal.new("456.7")
      assert account.org == "some updated org"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Control.update_account(account, @invalid_attrs)
      assert account == Control.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Control.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Control.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Control.change_account(account)
    end
  end

  describe "accounts" do
    alias Ledger.Control.Account

    import Ledger.ControlFixtures

    @invalid_attrs %{account: nil, amount: nil, org: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Control.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Control.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{account: 42, amount: "120.5", org: "some org"}

      assert {:ok, %Account{} = account} = Control.create_account(valid_attrs)
      assert account.account == 42
      assert account.amount == Decimal.new("120.5")
      assert account.org == "some org"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Control.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{account: 43, amount: "456.7", org: "some updated org"}

      assert {:ok, %Account{} = account} = Control.update_account(account, update_attrs)
      assert account.account == 43
      assert account.amount == Decimal.new("456.7")
      assert account.org == "some updated org"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Control.update_account(account, @invalid_attrs)
      assert account == Control.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Control.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Control.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Control.change_account(account)
    end
  end
end
