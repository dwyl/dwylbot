# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dwylbot,
  ecto_repos: [Dwylbot.Repo]

# Configures the endpoint
config :dwylbot, Dwylbot.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: Dwylbot.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dwylbot.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# define name of the github application
config :dwylbot, :github_app_name, System.get_env("GITHUB_APP_NAME")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
