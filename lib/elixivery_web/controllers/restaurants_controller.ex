defmodule ElixiveryWeb.RestaurantsController do
  use ElixiveryWeb, :controller

  def show(conn, %{"id" => id}) do
    with {:ok, restaurant: restaurant} <- Elixivery.Services.Restaurant.Find.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{restaurant: restaurant})
    end
  end
end
