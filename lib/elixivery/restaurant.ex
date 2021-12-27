defmodule Elixivery.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "restaurants" do
    field :name, :string
    field :delivery_mean_time, :integer
    field :status, Ecto.Enum, values: [:open, :closed]
    field :open_at, :string
    field :close_at, :string
    belongs_to :restaurant_kind, Elixivery.RestaurantKind
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params, restaurant_kind) do
    struct
    |> cast(params, [:name, :delivery_mean_time, :status, :open_at, :close_at])
    |> put_assoc(:restaurant_kind, restaurant_kind)
    |> validate_required([:name, :delivery_mean_time, :status, :open_at, :close_at])
    |> unique_constraint([:name])
  end

end
