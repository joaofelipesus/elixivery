defmodule Elixivery.Services.Restaurant.UpdateTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Services.Restaurant.Update
  alias Elixivery.Restaurant

  describe "#call/2" do
    setup do
      restaurant = insert(:restaurant)

      params = %{
        "name" => "Some new name",
        "delivery_mean_time" => 45,
        "open_at" => "21:15",
        "close_at" => "4:00",
        "status" => "closed",
        "restaurant_kind_id" => restaurant.restaurant_kind_id
      }

      {:ok, restaurant: restaurant, params: params}
    end

    test "when params are ok", state do
      restaurant_kind = insert(:restaurant_kind, name: "Russian")
      params = %{state[:params] | "restaurant_kind_id" => restaurant_kind.id}
      {status, %Restaurant{} = restaurant} = Update.call(state[:restaurant].id, params)
      assert status == :ok

      assert %Elixivery.Restaurant{
               close_at: "4:00",
               delivery_mean_time: 45,
               id: _id,
               name: "Some new name",
               open_at: "21:15",
               restaurant_kind: %Elixivery.RestaurantKind{
                 id: _,
                 name: "Russian",
                 updated_at: _
               },
               restaurant_kind_id: _,
               status: :closed
             } = restaurant
    end

    test "when received id dont belong to a restaurant", state do
      response = Update.call("b72b1220-68ad-11ec-90d6-0242ac120003", state[:params])
      assert response == {:error, [message: "Restaurant not found"]}
    end

    test "when restaurant kind id is invalid", state do
      params = %{state[:params] | "restaurant_kind_id" => "5736dcd6-68ae-11ec-90d6-0242ac120003"}
      response = Update.call(state[:restaurant].id, params)
      assert response == {:error, [message: "Restaurant kind invalid"]}
    end

    test "when params has a validation error", state do
      params = %{state[:params] | "name" => nil}
      {:error, %Ecto.Changeset{errors: errors}} = Update.call(state[:restaurant].id, params)
      assert errors == [name: {"can't be blank", [validation: :required]}]
    end
  end
end
