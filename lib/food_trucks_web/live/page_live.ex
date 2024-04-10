# Author: Nathan Casados
defmodule FoodTrucksWeb.PageLive do
  use FoodTrucksWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(
       :food_trucks,
       FoodTrucks.filter_food_trucks_by_food("")
     )
     |> assign(:food_search, nil)
     |> assign(:google_maps_api_key, Application.get_env(:food_trucks, :google_maps_api_key))}
  end

  @impl true
  def handle_event("search-food", %{"food" => food}, socket) do
    {:noreply,
     socket
     |> assign(:food_trucks, FoodTrucks.filter_food_trucks_by_food(food))
     |> assign(:food_search, food)}
  end
end
