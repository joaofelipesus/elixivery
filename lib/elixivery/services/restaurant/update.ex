defmodule Elixivery.Services.Restaurant.Update do
  alias Elixivery.{Repo, Restaurant}
  alias Elixivery.Services.Restaurant.Utils

  def call(id, params) do
    case Utils.valid_restaurant_kind?(params["restaurant_kind_id"]) do
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
        |> Utils.reload_restaurant()
    end
  end
end
