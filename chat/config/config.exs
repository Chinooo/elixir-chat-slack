# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :chat,
  ecto_repos: [Chat.Repo]

# Configures the endpoint
config :chat, Chat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fn1Jp5sO+Ul3zuPXJWI+pSOZ/A+juWdUUPoM7XLtYznIfEajQ6MM4NU/TyOencVY",
  render_errors: [view: Chat.ErrorView, accepts: ~w(json)],
  pubsub: [name: Chat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :guardian, Guardian,
    allowed_algos: ["HS512"], # optional
    verify_module: Guardian.JWT,  # optional
    issuer: "guardian_auth",
    ttl: { 30, :days },
    allowed_drift: 2000,
    verify_issuer: true, # optional
    secret_key: System.get_env("GUARDIAN_SECRET") || "Yddhc10dCoOTN1/Lk6+nYmfGp1hW48k8G6r6RF6HUoT62KZtfY+FKCqOIL/RamdQ",
    serializer: Chat.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
