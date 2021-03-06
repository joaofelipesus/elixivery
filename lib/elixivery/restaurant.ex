defmodule Elixivery.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @attributes [:name, :delivery_mean_time, :status, :open_at, :close_at, :restaurant_kind_id]

  schema "restaurants" do
    field :name, :string
    field :delivery_mean_time, :integer
    field :status, Ecto.Enum, values: [:open, :closed]
    field :open_at, :string
    field :close_at, :string
    belongs_to :restaurant_kind, Elixivery.RestaurantKind, on_replace: :update
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @attributes)
    |> validate_required(@attributes)
    |> unique_constraint([:name])
  end
end
