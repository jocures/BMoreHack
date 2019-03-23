use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gohireme, GohiremeWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gohireme, Gohireme.Repo,
  username: "postgres",
  password: "postgres",
  database: "gohireme_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :arc,
  storage: Arc.Storage.Local
