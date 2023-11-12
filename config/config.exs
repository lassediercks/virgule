import Config

config :virgule, Virgule.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 1

config :virgule, ecto_repos: [Virgule.Repo]
config :virgule, PORT: System.get_env("PORT")
config :virgule, ADMIN_PATH: "virgule"
config :virgule, API_ROUTE: "api"
