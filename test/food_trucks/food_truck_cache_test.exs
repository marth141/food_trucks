# Author: Nathan Casados
defmodule FoodTrucks.FoodTruckCacheTest do
  use ExUnit.Case, async: true

  test "Loaded test data json to cache" do
    assert %{"applicant" => "Philz Coffee Truck"} =
             FoodTrucks.read_foodtruck_cache() |> List.first()
  end
end
