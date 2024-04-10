# Author: Nathan Casados
defmodule SfgovApi do
  @moduledoc """
  Used as kind of an interface for Sfgov's API.
  """

  @doc """
  Gets all of the approved food trucks from SfgovApi.

  More info here https://dev.socrata.com/consumers/getting-started.html
  """
  def get_approved_food_trucks do
    case Application.get_env(:food_trucks, :env) do
      :test ->
        File.read!("test/food_trucks_web/controllers/Foodtrucks.json")
        |> simplify_results()

      _ ->
        with {:ok, %{body: body, status: 200}} <- get_approved_mobile_food_facility_permits() do
          simplify_results(body)
        end
    end
  end

  defp get_approved_mobile_food_facility_permits() do
    Finch.build(
      :get,
      URI.encode("https://data.sfgov.org/resource/rqzj-sfat.json?$where=status == 'APPROVED'")
    )
    |> Finch.request(FoodTrucks.Finch)
  end

  # The food truck results from Sfgov come with a lot of information.
  # However, of all the information received, I think that
  # ["status", "applicant", "latitude", "longitude", "fooditems", "schedule", "address"]
  # are probably the most relevant. Status to know it's approved (or not),
  # applicant to know whose food truck, latitude and longitude to put on a map,
  # fooditems to know what food the truck has, schedule to know when they operate,
  # and address to know where to find the food truck in a more human way than latitude and longitude.
  defp simplify_results(body) do
    body = Jason.decode!(body)
    keys = body |> List.first() |> Map.keys()

    body
    |> Enum.map(fn o ->
      Map.drop(
        o,
        keys --
          ["status", "applicant", "latitude", "longitude", "fooditems", "schedule", "address"]
      )
    end)
  end
end
