# Author: Nathan Casados
defmodule FoodTrucksWeb.PageController do
  use FoodTrucksWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
