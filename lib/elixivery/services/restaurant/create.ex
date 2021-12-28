defmodule Elixivery.Services.Restaurant.Create do
  alias Elixivery.{Repo, Restaurant, RestaurantKind}

  def call(params) do
    case restaurant_kind = restaurant_kind(params["restaurant_kind_id"]) do
      nil -> {:error, message: "Restaurant kind id invalid."}
      _ ->
        params
        |> Restaurant.changeset(restaurant_kind)
        |> Repo.insert()
    end
  end

  # TODO: treat when received id is invalid
  defp restaurant_kind(restaurant_kind_id) do
    Repo.get(RestaurantKind, restaurant_kind_id)
  end
end
