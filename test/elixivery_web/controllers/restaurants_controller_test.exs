defmodule ElixiveryWeb.RestaurantsControllerTest do
  use ElixiveryWeb.ConnCase, async: true
  import Elixivery.Factory

  describe "#index/2" do
    test "returns status ok and a list with all restaurants", %{conn: conn} do
      insert(:restaurant)

      response =
        conn
        |> get(Routes.restaurants_path(conn, :index))
        |> json_response(:ok)

      assert [
               %{
                 "close_at" => "23:00",
                 "delivery_mean_time" => 30,
                 "id" => _,
                 "name" => "McDonalds",
                 "open_at" => "18:00",
                 "restaurant_kind" => %{
                   "id" => _,
                   "name" => "Italian"
                 },
                 "status" => "closed"
               }
             ] = response
    end
  end

  describe "#show/2" do
    test "when received id is valid", %{conn: conn} do
      restaurant = insert(:restaurant)

      response =
        conn
        |> get(Routes.restaurants_path(conn, :show, restaurant.id))
        |> json_response(:ok)

      assert %{
               "close_at" => "23:00",
               "delivery_mean_time" => 30,
               "id" => _id,
               "name" => "McDonalds",
               "open_at" => "18:00",
               "restaurant_kind" => %{
                 "id" => _restaurant_kind_id,
                 "name" => "Italian"
               },
               "status" => "closed"
             } = response
    end

    test "when received id doesnt belong to a restaurant", %{conn: conn} do
      response =
        conn
        |> get(Routes.restaurants_path(conn, :show, "226df6c4-6787-11ec-90d6-0242ac120003"))
        |> json_response(:not_found)

      assert %{"message" => "Restaurant not found"} = response
    end
  end

  describe "#create/2" do
    test "when received params are ok", %{conn: conn} do
      restaurant_kind = insert(:restaurant_kind)

      params = %{
        "name" => "Dog Show",
        "delivery_mean_time" => 30,
        "status" => "open",
        "open_at" => "19:00",
        "close_at" => "21:30",
        "restaurant_kind_id" => restaurant_kind.id
      }

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "close_at" => "21:30",
               "delivery_mean_time" => 30,
               "id" => _id,
               "name" => "Dog Show",
               "open_at" => "19:00",
               "restaurant_kind" => %{
                 "id" => _restaurant_kind_id,
                 "name" => "Italian"
               },
               "status" => "open"
             } = response
    end

    test "when received params has problems", %{conn: conn} do
      restaurant_kind = insert(:restaurant_kind)

      params = %{
        "name" => "Dog Show",
        "delivery_mean_time" => 30,
        "status" => "opened",
        "open_at" => "19:00",
        "close_at" => "21:30",
        "restaurant_kind_id" => restaurant_kind.id
      }

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"messages" => %{"status" => ["is invalid"]}} == response
    end
  end

  describe "#update/2" do
    test "when params are ok", %{conn: conn} do
      restaurant = insert(:restaurant)

      params = %{
        "name" => "Dog Show UPDATED",
        "delivery_mean_time" => 30,
        "status" => "open",
        "open_at" => "19:00",
        "close_at" => "21:30",
        "restaurant_kind_id" => restaurant.restaurant_kind_id,
        "id" => restaurant.id
      }

      response =
        conn
        |> put(Routes.restaurants_path(conn, :update, restaurant.id,params))
        |> json_response(:ok)

      assert %{
              "close_at" => "21:30",
              "delivery_mean_time" => 30,
              "id" => _id,
              "name" => "Dog Show UPDATED",
              "open_at" => "19:00",
              "restaurant_kind" => %{
                "id" => _restaurant_kind_id,
                "name" => "Italian"
              },
              "status" => "open"
            } = response
    end

    test "when received params has problems", %{conn: conn} do
      restaurant = insert(:restaurant)

      params = %{
        "name" => "Dog Show",
        "delivery_mean_time" => 30,
        "status" => "opened",
        "open_at" => "19:00",
        "close_at" => "21:30",
        "restaurant_kind_id" => restaurant.restaurant_kind_id
      }

      response =
        conn
        |> put(Routes.restaurants_path(conn, :update, restaurant.id, params))
        |> json_response(:bad_request)

      assert %{"messages" => %{"status" => ["is invalid"]}} == response
    end
  end
end
