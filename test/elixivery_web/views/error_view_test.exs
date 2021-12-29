defmodule ElixiveryWeb.ErrorViewTest do
  use ElixiveryWeb.ConnCase, async: true
  alias ElixiveryWeb.ErrorView
  import Elixivery.Factory

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end

  test "renders 400.json" do
    restaurant = insert(:restaurant, name: "Eat Fit")

    params = %{
      name: "Eat Fit",
      status: :closed,
      open_at: "18:00",
      close_at: "23:00",
      delivery_mean_time: 30,
      restaurant_kind_id: restaurant.restaurant_kind_id
    }

    {:error, %Ecto.Changeset{} = changeset} =
      params
      |> Elixivery.Restaurant.changeset()
      |> Elixivery.Repo.insert()

    serialized_errors = render(ErrorView, "400.json", %{errors: changeset})
    assert serialized_errors == %{messages: %{name: ["has already been taken"]}}
  end
end
