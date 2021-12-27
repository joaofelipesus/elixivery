defmodule Elixivery.Repo.Migrations.RestaurantStatusType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE restaurant_status AS ENUM('open', 'closed')"
    down_query = "DROP TYPE restaurant_status"
    execute(up_query, down_query)
  end
end
