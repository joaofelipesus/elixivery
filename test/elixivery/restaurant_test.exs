defmodule Elixivery.RestaurantTest do
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Restaurant

  setup do
    restaurant_kind = insert(:restaurant_kind)
    {:ok, restaurant_kind: restaurant_kind}
  end

  test '#changeset/3 when params are ok', state do
    changeset = Restaurant.changeset(restaurant_params_factory(), state[:restaurant_kind])
    assert %{valid?: true} = changeset
  end

  test '#changeset/3 when received params has problems', state do
    params = %{name: nil, status: nil, open_at: nil, close_at: nil, delivery_mean_time: nil}
    changeset = Restaurant.changeset(params, state[:restaurant_kind])
    assert %{
      valid?: false,
      errors: [
        name: {"can't be blank", [validation: :required]},
        delivery_mean_time: {"can't be blank", [validation: :required]},
        status: {"can't be blank", [validation: :required]},
        open_at: {"can't be blank", [validation: :required]},
        close_at: {"can't be blank", [validation: :required]}
      ]
    } = changeset
  end

  test '#changeset/3 when received restaurant kind is invalid' do
    params = restaurant_params_factory()
    changeset = Restaurant.changeset(params, nil)
    assert %{
      valid?: false,
      errors: [restaurant_kind: {"can't be blank", [validation: :required]}]
    } = changeset
  end
end
