defmodule Elixivery.Repo.Migrations.CreateRestaurantTable do
  use Ecto.Migration

  def change do
    create table("restaurants") do
      add :name, :string
      add :delivery_mean_time, :integer
      add :status, :restaurant_status
      add :open_at, :string
      add :close_at, :string
    end

    create unique_index(:restaurants, [:name])
  end
end
