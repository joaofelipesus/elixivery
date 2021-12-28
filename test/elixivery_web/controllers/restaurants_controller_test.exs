defmodule ElixiveryWeb.RestaurantsControllerTest do
  use ElixiveryWeb.ConnCase, async: true
  import Elixivery.Factory

  describe "#show/2" do
    test "when received id is valid", %{conn: conn} do
      restaurant = insert(:restaurant)
      response = conn
      |> get(Routes.restaurants_path(conn, :show, restaurant.id))
      |> json_response(:ok)
      assert %{
        "close_at" => "23:00",
        "delivery_mean_time" => 30,
        "id" => _id,
        "name" => "McDonalds",
        "open_at" => "18:00",
        "restaurant_kind" => %{
          "id" => _restaurant_kind_id,
          "name" => "Italian"
        },
        "status" => "closed"
      } = response
    end

    test "when received id doesnt belong to a restaurant", %{conn: conn} do
      response = conn
      |> get(Routes.restaurants_path(conn, :show, "226df6c4-6787-11ec-90d6-0242ac120003"))
      |> json_response(:not_found)
      assert %{"message" => "Restaurant not found"} = response
    end
  end
end
