# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elixivery.Repo.insert!(%Elixivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Elixivery.RestaurantKind
alias Elixivery.Repo

Repo.insert(%RestaurantKind{name: "Fast Food"})
Repo.insert(%RestaurantKind{name: "Japonese"})
Repo.insert(%RestaurantKind{name: "Italian"})
Repo.insert(%RestaurantKind{name: "Pizza"})
Repo.insert(%RestaurantKind{name: "Healthy"})
