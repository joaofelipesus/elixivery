defmodule ElixiveryWeb.RestaurantsView do
  use ElixiveryWeb, :view
  alias Elixivery.Restaurant

  def render("index.json", %{restaurants: restaurants}) do
    Enum.map(restaurants, fn restaurant -> serialize_restaurant(restaurant) end)
  end

  def render("show.json", %{restaurant: %Restaurant{} = restaurant}), do: serialize_restaurant(restaurant)

  defp serialize_restaurant(%Restaurant{} = restaurant) do
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
