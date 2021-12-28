defmodule Elixivery.Services.Restaurant.List do
  alias Elixivery.Repo
  alias Elixivery.Restaurant

  def all do
    Repo.all(Restaurant)
    |> Repo.preload(:restaurant_kind)
  end
end
