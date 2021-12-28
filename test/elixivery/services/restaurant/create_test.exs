defmodule Elixivery.Services.Restaurant.CreateTest do
  use ExUnit.Case
  use Elixivery.DataCase, async: true
  import Elixivery.Factory

  setup do
    restaurant_kind = insert(:restaurant_kind)
    {:ok, restaurant_kind: restaurant_kind}
  end

  describe "#call/1" do
    test "when received params are ok", state do
      params = %{
        "close_at" => "23:00",
        "delivery_mean_time" => 15,
        "name" => "Asuki",
        "open_at" => "18:00",
        "restaurant_kind_id" => state[:restaurant_kind].id,
        "status" => :open
      }
      result = Elixivery.Services.Restaurant.Create.call(params)
      assert {:ok, %Elixivery.Restaurant{}} = result
    end

    test "when received param has problems", state do
      params = %{
        "close_at" => "23:00",
        "delivery_mean_time" => 15,
        "name" => nil,
        "open_at" => "18:00",
        "restaurant_kind_id" => state[:restaurant_kind].id,
        "status" => :open
      }
      result = Elixivery.Services.Restaurant.Create.call(params)
      assert {:error, %Ecto.Changeset{errors: errors}} = result
      assert errors == [name: {"can't be blank", [validation: :required]}]
    end

    test "when received restaurant kind id is invalid" do
      params = %{
        "close_at" => "23:00",
        "delivery_mean_time" => 15,
        "name" => "Asuki",
        "open_at" => "18:00",
        "restaurant_kind_id" => "c53ce22e-5a71-45dc-ad1e-cde634dba270",
        "status" => :open
      }
      result = Elixivery.Services.Restaurant.Create.call(params)
      assert {:error, [message: "Restaurant kind id invalid."]} == result
    end
  end

end
