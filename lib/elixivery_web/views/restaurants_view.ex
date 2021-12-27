defmodule ElixiveryWeb.RestaurantsView do
  def render("show.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      name: restaurant.name,
      delivery_mean_time: restaurant.delivery_mean_time,
      open_at: restaurant.open_at,
      close_at: restaurant.close_at,
      status: restaurant.status,
      restaurant_kind: %{
        id: restaurant.restaurant_kind.id,
        name: restaurant.restaurant_kind.name
      }
    }
  end
end
