defmodule Elixivery.Services.Restaurant.ListTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Services.Restaurant.List

  describe "#call/0" do
    test "when there are restaurants" do
      restaurant_kind = insert(:restaurant_kind, name: "Fast food")
      insert(:restaurant, name: "McDonald's", restaurant_kind: restaurant_kind)
      insert(:restaurant, name: "Burger King", restaurant_kind: restaurant_kind)
      insert(:restaurant, name: "Au Au", restaurant_kind: restaurant_kind)
      restaurants = List.all()
      assert length(restaurants) == 3
    end

    test "when there is no restaurants it returns an empty list" do
      assert List.all() == []
    end
  end
end
