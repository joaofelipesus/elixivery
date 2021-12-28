defmodule ElixiveryWeb.FallbackController do
  alias ElixiveryWeb.ErrorView
  use ElixiveryWeb, :controller

  def call(conn, {:error, message}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", message: message[:message])
  end
end
