defmodule Elixivery.Factory do
  use ExMachina.Ecto, repo: Elixivery.Repo

  def restaurant_kind_factory do
    %Elixivery.RestaurantKind{
      name: "Italian"
    }
  end
end
