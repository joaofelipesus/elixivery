defmodule ElixiveryWeb.RestaurantsController do
  use ElixiveryWeb, :controller
  alias Elixivery.Services.Restaurant.Find
  alias Elixivery.Repo

  action_fallback ElixiveryWeb.FallbackController

  def index(conn, _params) do
    restaurants = Repo.all(Elixivery.Restaurant)
    |> Repo.preload(:restaurant_kind)
    conn
    |> put_status(:ok)
    |> render("index.json", %{restaurants: restaurants})
  end

  def show(conn, %{"id" => id}) do
    with {:ok, restaurant: restaurant} <- Find.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{restaurant: restaurant})
    end
  end
end
