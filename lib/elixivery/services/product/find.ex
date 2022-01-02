defmodule Elixivery.Services.Product.Find do
  alias Elixivery.Repo
  alias Elixivery.Product

  def by_id(id) do
    product = Repo.get(Product, id)
    |> Repo.preload(:restaurant)

    case product do
      %Elixivery.Product{} -> {:ok, product}
      nil -> {:error, "Product not found"}
    end
  end
end
