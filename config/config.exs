# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :big_snips,
  ecto_repos: [BigSnips.Repo]

# Configures the endpoint
config :big_snips, BigSnips.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+fADMZrEMeUg+8N1bbLhL5zEYStTLM/CqLqNlurM0eD7PBWNROaZ+MC4DoBZlZdU",
  render_errors: [view: BigSnips.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BigSnips.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Unicorn",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "GFirMsmChzWa36UMMLrOtnquifGm+yF4eHpjL7Po2IoIN8jOTaGKD+dIknVFYZ8h",
  serializer: BigSnips.GuardianSerializer

config :scrivener_html,
  routes_helper: BigSnips.Router.Helpers

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
