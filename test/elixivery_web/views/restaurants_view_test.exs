defmodule RestaurantsViewTest do
  use ElixiveryWeb.ConnCase, async: true
  import Phoenix.View
  import Elixivery.Factory
  alias ElixiveryWeb.RestaurantsView

  describe "render(\"show.json\", %{restaurant: restaurant})" do
    test "renders an restaurant" do
      restaurant = insert(:restaurant)

      {:ok, restaurant: restaurant_found} =
        Elixivery.Services.Restaurant.Find.by_id(restaurant.id)

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

  describe "render(\"index.json\", %{restaurants: restaurants})" do
    setup do
      restaurant_kind = insert(:restaurant_kind, name: "Japonese")
      insert(:restaurant, name: "Asuki", restaurant_kind: restaurant_kind)
      insert(:restaurant, name: "King Temaki", restaurant_kind: restaurant_kind)
      insert(:restaurant, name: "Taysho", restaurant_kind: restaurant_kind)
      restaurants = Elixivery.Services.Restaurant.List.all()
      {:ok, restaurants: restaurants}
    end

    test "it returns a list with all restaurants", state do
      serialized_restaurants =
        render(RestaurantsView, "index.json", %{restaurants: state[:restaurants]})

      assert [
               %{
                 close_at: "23:00",
                 delivery_mean_time: 30,
                 id: _,
                 name: "Asuki",
                 open_at: "18:00",
                 restaurant_kind: %{
                   id: _,
                   name: "Japonese"
                 },
                 status: :closed
               },
               %{
                 close_at: "23:00",
                 delivery_mean_time: 30,
                 id: _,
                 name: "King Temaki",
                 open_at: "18:00",
                 restaurant_kind: %{
                   id: _,
                   name: "Japonese"
                 },
                 status: :closed
               },
               %{
                 close_at: "23:00",
                 delivery_mean_time: 30,
                 id: _,
                 name: "Taysho",
                 open_at: "18:00",
                 restaurant_kind: %{
                   id: _,
                   name: "Japonese"
                 },
                 status: :closed
               }
             ] = serialized_restaurants
    end
  end
end
