defmodule ElixiveryWeb.ProductsView do
  use ElixiveryWeb, :view
  alias Elixivery.Product

  def render("show.json", %{product: %Product{} = product}), do: serialize(product)

  def render("index.json", %{products: products}) do
    Enum.map(restaurants, fn restaurant -> serialize(restaurant) end)
  end

  defp serialize(%Product{} = product) do
    %{
      id: product.id,
      name: product.name,
      price: product.price,
      kind: product.kind,
      restaurant_id: product.restaurant_id,
      restaurant: %{
        id: product.restaurant.id,
        name: product.restaurant.name
      }
    }
  end
end
