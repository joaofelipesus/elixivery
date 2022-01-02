defmodule Elixivery.Repo.Migrations.CreateProductKindType do
  use Ecto.Migration

  def change do
    up_query = "CREATE TYPE product_kind AS ENUM('food', 'drink', 'deasert')"
    down_query = "DROP TYPE product_kind"
    execute(up_query, down_query)
  end
end
