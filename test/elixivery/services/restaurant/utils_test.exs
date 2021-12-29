defmodule Elixivery.Services.Restaurant.UtilsTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Services.Restaurant.Utils
  alias Elixivery.{Restaurant, RestaurantKind}

  describe "#reload_restaurant/1" do
    test "returns a restaurant with restaurant_kind loaded" do
      restaurant = insert(:restaurant)
      assert %Restaurant{restaurant_kind: %RestaurantKind{}} = Utils.reload_restaurant(restaurant)
    end
  end

  describe "valid_restaurant_kind?/1" do
    test "when receive a valid restaurant kind id" do
      restaurant_kind = insert(:restaurant_kind)
      assert true == Utils.valid_restaurant_kind?(restaurant_kind.id)
    end

    test "when received id doesn't match with any restaurant" do
      assert false == Utils.valid_restaurant_kind?("d21315ca-68b6-11ec-90d6-0242ac120003")
    end
  end
end
