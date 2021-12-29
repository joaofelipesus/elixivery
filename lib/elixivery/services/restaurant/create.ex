defmodule Elixivery.Services.Restaurant.Create do
  alias Elixivery.{Repo, Restaurant}
  alias Elixivery.Services.Restaurant.Utils

  def call(params) do
    case Utils.valid_restaurant_kind?(params["restaurant_kind_id"]) do
      true ->
        params
        |> Restaurant.changeset()
        |> Repo.insert()
        |> Utils.reload_restaurant()

      false ->
        {:error, message: "Restaurant kind id invalid."}
    end
  end
end
