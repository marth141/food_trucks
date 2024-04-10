# Author: Nathan Casados
import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_trucks, FoodTrucksWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "uLM1skPXnE0WOHOI7gmSO0B7fVM5jWj8aifak8A+7Dy+9xkNfetWKLc2UST/p1Mg",
  server: false

# In test we don't send emails.
config :food_trucks, FoodTrucks.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
