defmodule Elixivery.Services.Restaurant.Find do
  def by_id(id) do
    restaurant = Elixivery.Repo.get(Elixivery.Restaurant, id)
    case restaurant do
      nil -> {:error, message: "Restaurant not found"}
      _ -> {:ok, restaurant: restaurant}
    end
  end
end
