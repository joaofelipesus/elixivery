defmodule ElixiveryWeb.ProductsController do
  use ElixiveryWeb, :controller
  alias Elixivery.Product

  action_fallback ElixiveryWeb.FallbackController
end
