defmodule Elixivery.Services.Restaurant.Create do
  alias Elixivery.{Repo, Restaurant, RestaurantKind}

  def call(params) do
    case valid_restaurant_kind?(params["restaurant_kind_id"]) do
      true ->
        params
        |> Restaurant.changeset
        |> Repo.insert()
        |> reload_restaurant()
      false -> {:error, message: "Restaurant kind id invalid."}
    end
  end

  defp valid_restaurant_kind?(restaurant_kind_id) do
    case Repo.get(RestaurantKind, restaurant_kind_id) do
      %RestaurantKind{} -> true
      _ -> false
    end
  end

  defp reload_restaurant(changeset) do
    case changeset do
      {:ok, restaurant} -> {:ok, Repo.preload(restaurant, :restaurant_kind, force: true)}
      error -> error
    end
  end
end
