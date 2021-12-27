defmodule RestaurantsViewTest do
  use ElixiveryWeb.ConnCase, async: true
  import Phoenix.View
  import Elixivery.Factory
  alias ElixiveryWeb.RestaurantsView

  test "render(show.json, %{restaurant: restaurant})" do
    restaurant = insert(:restaurant)
    {:ok, restaurant: restaurant_found} = Elixivery.Services.Restaurant.Find.by_id(restaurant.id)
    response = render(RestaurantsView, "show.json", %{restaurant: restaurant_found})
    assert %{
      close_at: "23:00",
      delivery_mean_time: 30,
      id: _id,
      name: "McDonalds",
      open_at: "18:00",
      restaurant_kind: %{
        id: _restaurant_kind_id,
        name: "Italian"
      },
      status: :closed
    } = response
  end
end
