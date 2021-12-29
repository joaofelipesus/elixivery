defmodule Elixivery.Services.Restaurant.Create do
  alias Elixivery.{Repo, Restaurant, RestaurantKind}

  def call(params) do
    case valid_restaurant_kind?(params["restaurant_kind_id"]) do
      true ->
        params
        |> Restaurant.changeset
        |> Repo.insert()
      false -> {:error, message: "Restaurant kind id invalid."}
    end
  end

  defp valid_restaurant_kind?(restaurant_kind_id) do
    case Repo.get(RestaurantKind, restaurant_kind_id) do
      %RestaurantKind{} -> true
      _ -> false
    end
  end
end
