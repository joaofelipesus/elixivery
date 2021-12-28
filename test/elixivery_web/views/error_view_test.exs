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
    params = restaurant_params_factory()
    params = %{params | name: "Eat Fit"}
    {:error, %Ecto.Changeset{} = changeset} =
      params
      |> Elixivery.Restaurant.changeset(restaurant.restaurant_kind)
      |> Elixivery.Repo.insert
    serialized_errors = render(ErrorView, "400.json", %{errors: changeset})
    assert serialized_errors == %{messages: %{name: ["has already been taken"]}}
  end
end
