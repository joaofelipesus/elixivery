defmodule Elixivery.Services.Restaurant.FindTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Services.Restaurant.Find

  test "#by_id/1 when received id belongs to a restaurant" do
    restaurant = insert(:restaurant)
    {status, restaurant: restaurant_found} = Find.by_id(restaurant.id)
    assert :ok == status
    assert restaurant_found.id == restaurant.id
  end

  test "#by_id/1 when received id doesn't belong to a restaurant" do
    {status, message: message} = Find.by_id("1b18acde-6755-11ec-90d6-0242ac120003")
    assert :error == status
    assert "Restaurant not found" == message
  end
end
