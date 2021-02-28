defmodule RocketpayWeb.AccountsView do
  use RocketpayWeb, :view

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance update was successful",
      account: %{
          id: account_id,
          balance: balance
      }
    }
  end

  def render("transaction.json", %{transaction: %TransactionResponse{from_account: from_account, to_account: to_account}}) do
    %{
      message: "Transaction was successful",
      transaction: %{
        from: %{
          id: from_account.id,
          balance: from_account.balance
        },
        to: %{
          id: to_account.id,
          balance: to_account.balance
        }
      }
    }
  end
end
