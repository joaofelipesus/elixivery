defmodule Elixivery.Factory do
  use ExMachina.Ecto, repo: Elixivery.Repo

  def restaurant_kind_factory do
    %Elixivery.RestaurantKind{
      name: "Italian"
    }
  end

  def restaurant_factory do
    %Elixivery.Restaurant{
      name: "McDonalds",
      status: :closed,
      open_at: "18:00",
      close_at: "23:00",
      delivery_mean_time: 30,
      restaurant_kind: build(:restaurant_kind)
    }
  end

  def restaurant_params_factory do
    %{
      name: "McDonalds",
      status: :closed,
      open_at: "18:00",
      close_at: "23:00",
      delivery_mean_time: 30
    }
  end

  def product_factory do
    %Elixivery.Product{
      kind: :drink,
      name: "Coca-Cola zero",
      price: 2.99,
      restaurant_id: build(:restaurant).id
    }
  end
end
