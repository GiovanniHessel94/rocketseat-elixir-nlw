defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all parameters are valid, returns an user" do
      params = %{
        name: "Hessel",
        password: "123456",
        nickname: "Hessel94",
        email: "hessel@banana",
        age: 27
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      assert %{
        name: "Hessel",
        nickname: "Hessel94",
        email: "hessel@banana",
        age: 27,
        id: ^user_id
        } = Repo.get(User, user_id)
      end

      test "when there are invalid params, returns the errors" do
        params = %{
          name: "Hessel",
          nickname: "Hessel94",
          email: "hessel@banana",
          age: 17
        }

        {:error, changeset} = Create.call(params)

        expected_errors = %{
          age: ["must be greater than or equal to 18"],
          password: ["can't be blank"]
        }

        assert errors_on(changeset) == expected_errors
      end
  end
end
