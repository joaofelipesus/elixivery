defmodule ElixiveryWeb.RestaurantsController do
  use ElixiveryWeb, :controller
  alias Elixivery.Services.Restaurant.{Find, List}

  action_fallback ElixiveryWeb.FallbackController

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> render("index.json", %{restaurants: List.all})
  end

  def show(conn, %{"id" => id}) do
    with {:ok, restaurant: restaurant} <- Find.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{restaurant: restaurant})
    end
  end
end
