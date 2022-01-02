defmodule Elixivery.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @attributes [:name, :price, :kind, :restaurant_id]

  schema "products" do
    field :name, :string
    field :price, :decimal
    field :kind, Ecto.Enum, values: [:food, :drink, :deseart]
    belongs_to :restaurant, Elixivery.Restaurant, on_replace: :update
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @attributes)
    |> validate_required(@attributes)
    |> unique_constraint(:unique_product_name, name: :unique_product_name)
  end
end
