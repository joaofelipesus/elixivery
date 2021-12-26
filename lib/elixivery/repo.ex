defmodule Elixivery.Repo do
  use Ecto.Repo,
    otp_app: :elixivery,
    adapter: Ecto.Adapters.Postgres
end
