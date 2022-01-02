defmodule Elixivery.Services.Product.FindTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Services.Product.Find
  alias Elixivery.Product

  describe "by_id/1" do
    test "when received id belongs to a product" do
      product = insert(:product)
      response = Find.by_id(product.id)
      assert {:ok, %Product{}} = response
    end

    test "when received id DONT belong to a product" do
      response = Find.by_id("bbbeea94-6bbb-11ec-90d6-0242ac120003")
      assert response == {:error, "Product not found"}
    end
  end
end
