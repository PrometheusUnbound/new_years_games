# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :new_years_games,
  ecto_repos: [NewYearsGames.Repo]

# Configures the endpoint
config :new_years_games, NewYearsGamesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yUxBtDuazdDSnicJfgUln6h5zb5xnWjwuDOgZMbleml1DxVPQN/Md7p6KRrTCjme",
  render_errors: [view: NewYearsGamesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NewYearsGames.PubSub,
  live_view: [signing_salt: "8sNyRfJ2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
