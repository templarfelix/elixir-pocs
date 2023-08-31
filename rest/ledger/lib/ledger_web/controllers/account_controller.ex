defmodule LedgerWeb.AccountController do
  use LedgerWeb, :controller

  alias Ledger.Cache
  alias Ledger.Control
  alias Ledger.Control.Account

  action_fallback LedgerWeb.FallbackController

  def index(conn, _params) do
    accounts = Control.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Control.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{account}")
      |> render(:show, account: account)
    end
  end

  def show(conn, %{"id" => id}) do

    case Cache.fetch(id) do
      nil ->
        Logger.info("debug get_account")
        account = Control.get_account!(id)
        MyCache.put(id, account)
      value ->
        json(conn, %{data: value})
    end

    account = Control.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Control.get_account!(id)

    with {:ok, %Account{} = account} <- Control.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Control.get_account!(id)

    with {:ok, %Account{}} <- Control.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
