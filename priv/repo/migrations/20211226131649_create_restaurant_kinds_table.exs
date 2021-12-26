defmodule Elixivery.Repo.Migrations.CreateRestaurantKindsTable do
  use Ecto.Migration

  def change do
    create table("restaurant_kinds") do
      add :name, :string
      timestamps()
    end

    create unique_index(:restaurant_kinds, [:name])
  end
end
