# Author: Nathan Casados
defmodule FoodTrucks do
  @moduledoc """
  Used for getting filters of food trucks from the Sfgov API.
  """
  alias FoodTrucks.FoodTruckCache

  @doc """
  Filters food trucks by food items with a given string.
  """
  def filter_food_trucks_by_food(filter) do
    read_foodtruck_cache()
    |> Enum.filter(fn ft ->
      Regex.match?(~r/#{filter}/i, ft["fooditems"])
    end)
    |> format_json()
  end

  def read_foodtruck_cache() do
    GenServer.call(FoodTruckCache, :read)
  end

  defp format_json(arg) do
    Jason.encode!(arg)
  end
end
