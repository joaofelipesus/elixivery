defmodule Elixivery.ProductTest do
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Product

  setup do
    restaurant = insert(:restaurant)

    params = %{
      kind: :drink,
      name: "Coca-Cola zero",
      price: 2.99,
      restaurant_id: restaurant.id
    }

    {:ok, restaurant: restaurant, params: params}
  end

  describe "changeset/2" do
    test "when params are ok", state do
      params = %{
        kind: :drink,
        name: "Coca-Cola zero",
        price: 2.99,
        restaurant_id: state[:restaurant].id
      }

      response =
        Elixivery.Product.changeset(params)
        |> Elixivery.Repo.insert()

      assert {:ok, %Elixivery.Product{}} = response
    end

    test "when name is already in use", state do
      insert(:product, name: "Coca-Cola zero", restaurant_id: state[:restaurant].id)

      result =
        state[:params]
        |> Product.changeset()
        |> Repo.insert()

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  unique_product_name:
                    {"has already been taken",
                     [constraint: :unique, constraint_name: "unique_product_name"]}
                ]
              }} = result
    end

    test "when missing required params" do
      result =
        %{}
        |> Product.changeset()

      assert %Ecto.Changeset{
               errors: [
                 name: {"can't be blank", [validation: :required]},
                 price: {"can't be blank", [validation: :required]},
                 kind: {"can't be blank", [validation: :required]},
                 restaurant_id: {"can't be blank", [validation: :required]}
               ],
               valid?: false
             } = result
    end
  end
end
