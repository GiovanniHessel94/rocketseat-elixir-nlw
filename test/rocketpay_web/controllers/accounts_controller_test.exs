defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{User, Account}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Hessel",
        password: "123456",
        nickname: "Hessel94",
        email: "hessel@banana",
        age: 27
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic bWVnYTpsb2RvbnRl")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all parameters are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "100.00"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:ok)


      assert %{"account" => %{"balance" => "100.00", "id" => _id}, "message" => "Balance update was successful"} = response
    end

    test "when there are invalid parameters, return an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "huehue"}

      response = conn
      |> post(Routes.accounts_path(conn, :deposit, account_id, params))
      |> json_response(:bad_request)


      assert response == %{"errors" => "Invalid value", "message" => "Bad request"}
    end
  end
end
