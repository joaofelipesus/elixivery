defmodule Elixivery.Services.Restaurant.Update do
  alias Elixivery.{Repo, Restaurant, RestaurantKind}

  def call(id, params) do
    case valid_restaurant_kind?(params["restaurant_kind_id"]) do
      true -> update_restaurant(id, params)
      false -> {:error, message: "Restaurant kind invalid"}
    end
  end

  defp update_restaurant(id, params) do
    case Elixivery.Services.Restaurant.Find.by_id(id) do
      {:error, message: message} -> {:error, message: message}
      {:ok, restaurant: %Elixivery.Restaurant{} = restaurant} ->
        restaurant
        |> Restaurant.changeset(params)
        |> Repo.update()
        |> reload_restaurant()
    end
  end

  defp reload_restaurant(changeset) do
    case changeset do
      {:ok, restaurant} -> {:ok, Repo.preload(restaurant, :restaurant_kind, force: true)}
      error -> error
    end
  end

  defp valid_restaurant_kind?(restaurant_kind_id) do
    case Repo.get(RestaurantKind, restaurant_kind_id) do
      %RestaurantKind{} -> true
      _ -> false
    end
  end
end
