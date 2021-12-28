defmodule ElixiveryWeb.FallbackController do
  alias ElixiveryWeb.ErrorView
  use ElixiveryWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("400.json", %{errors: changeset})
  end

  def call(conn, {:error, message}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json", message: message[:message])
  end
end
