defmodule Elixivery.Services.Restaurant.Find do
  alias Elixivery.Repo

  def by_id(id) do
    restaurant = Repo.get(Elixivery.Restaurant, id)
      |> Repo.preload(:restaurant_kind)
    case restaurant do
      nil -> {:error, message: "Restaurant not found"}
      _ -> {:ok, restaurant: restaurant}
    end
  end
end
