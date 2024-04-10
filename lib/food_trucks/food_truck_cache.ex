# Author: Nathan Casados
defmodule FoodTrucks.FoodTruckCache do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    state = []
    {:ok, state, {:continue, :hydrate}}
  end

  @impl true
  def handle_continue(:hydrate, _state) do
    {:noreply, SfgovApi.get_approved_food_trucks()}
  end

  @impl true
  def handle_call(:read, _from, state) do
    {:reply, state, state}
  end
end
