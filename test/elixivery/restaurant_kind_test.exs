defmodule Elixivery.RestaurantKindTest do
  use Elixivery.DataCase, async: true
  alias Elixivery.RestaurantKind
  alias Elixivery.Repo
  import Elixivery.Factory

  test "When all params are ok" do
    params = %{name: "Japonese"}
    response = RestaurantKind.changeset(params)
    assert %{valid?: true, changes: %{name: "Japonese"}} = response
  end

  test "when name is already in use" do
    insert(:restaurant_kind, name: "Italian")
    response = Repo.insert(RestaurantKind.changeset(%{name: "Italian"}))
    assert {:error, %Ecto.Changeset{
      valid?: false,
      errors: [
        name: {"has already been taken", [constraint: :unique, constraint_name: "restaurant_kinds_name_index"]}
      ]}
    } = response
  end
end
