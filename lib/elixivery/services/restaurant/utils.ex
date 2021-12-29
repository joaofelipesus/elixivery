defmodule Elixivery.Services.Restaurant.Utils do
  alias Elixivery.{Repo, RestaurantKind}

  def reload_restaurant(changeset) do
    case changeset do
      {:ok, restaurant} -> {:ok, Repo.preload(restaurant, :restaurant_kind, force: true)}
      error -> error
    end
  end

  def valid_restaurant_kind?(restaurant_kind_id) do
    case Repo.get(RestaurantKind, restaurant_kind_id) do
      %RestaurantKind{} -> true
      _ -> false
    end
  end
end
