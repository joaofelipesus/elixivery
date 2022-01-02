defmodule ElixiveryWeb.ProductsViewTest do
  use ElixiveryWeb.ConnCase, async: true
  import Phoenix.View
  import Elixivery.Factory
  alias ElixiveryWeb.RestaurantsView

  describe "render(\"show.json\", %{product: product})" do
    product = insert(:product)
    # continue
  end
end
