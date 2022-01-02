defmodule Elixivery.Repo.Migrations.CreateProductsTable do
  use Ecto.Migration

  def change do
    create table("products") do
      add :name, :string
      add :price, :decimal
      add :kind, :product_kind
      add :restaurant_id, references(:restaurants, type: :binary_id)
      timestamps()
    end

    create unique_index(:products, [:name, :restaurant_id], name: :unique_product_name)
  end
end
