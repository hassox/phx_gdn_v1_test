# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :guardian_v1_test,
  ecto_repos: [GuardianV1Test.Repo]

# Configures the endpoint
config :guardian_v1_test, GuardianV1Test.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n1qv78Z+M9D0aiRI9sfKDIKR/9uoBJh9X3aCVlYFz6Q+ypWTk9VTvh9oMRm84HNd",
  render_errors: [view: GuardianV1Test.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GuardianV1Test.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian_v1_test, GuardianV1Test.Guardian.AccessPipeline,
  module: GuardianV1Test.Guardian,
  error_handler: GuardianV1Test.Guardian.ErrorHandler

config :guardian_v1_test, GuardianV1Test.Guardian.MaybePipeline,
  module: GuardianV1Test.Guardian,
  error_handler: GuardianV1Test.Guardian.ErrorHandler


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
