defmodule Elixivery.RestaurantTest do
  use Elixivery.DataCase, async: true
  import Elixivery.Factory
  alias Elixivery.Restaurant

  setup do
    restaurant_kind = insert(:restaurant_kind)

    params = %{
      "name" => "Some new name",
      "delivery_mean_time" => 45,
      "open_at" => "21:15",
      "close_at" => "4:00",
      "status" => "closed",
      "restaurant_kind_id" => restaurant_kind.id
    }

    {:ok, params: params}
  end

  test "#changeset/3 when params are ok", state do
    changeset = Restaurant.changeset(state[:params])
    assert %{valid?: true} = changeset
  end

  test "#changeset/3 when received params has problems" do
    params = %{name: nil, status: nil, open_at: nil, close_at: nil, delivery_mean_time: nil}
    changeset = Restaurant.changeset(params)

    assert %{
             valid?: false,
             errors: [
               name: {"can't be blank", [validation: :required]},
               delivery_mean_time: {"can't be blank", [validation: :required]},
               status: {"can't be blank", [validation: :required]},
               open_at: {"can't be blank", [validation: :required]},
               close_at: {"can't be blank", [validation: :required]},
               restaurant_kind_id: {"can't be blank", [validation: :required]}
             ]
           } = changeset
  end
end
