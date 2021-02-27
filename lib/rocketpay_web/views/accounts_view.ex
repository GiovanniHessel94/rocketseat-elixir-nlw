defmodule RocketpayWeb.AccountsView do
  use RocketpayWeb, :view

  alias Rocketpay.Account

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Your deposit has been taken with success",
      account: %{
          id: account_id,
          balance: balance
      }
    }
  end
end
