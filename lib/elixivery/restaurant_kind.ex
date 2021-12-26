defmodule Elixivery.RestaurantKind do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "restaurant_kinds" do
    field :name, :string
    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint([:name])
  end
end
