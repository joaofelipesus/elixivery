defmodule ElixiveryWeb.RestaurantsController do
  use ElixiveryWeb, :controller
  alias Elixivery.Services.Restaurant.Find

  action_fallback ElixiveryWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, restaurant: restaurant} <- Find.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", %{restaurant: restaurant})
    end
  end
end
