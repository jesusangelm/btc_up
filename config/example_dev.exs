import Config

# Renombre este archivo a dev.exs

## Configuracion para Ecto
config :btc_up, ecto_repos: [BtcUp.Repo]

config :btc_up, BtcUp.Repo,
  username: "your_db_username",
  password: "your_db_password",
  database: "your_db_name",
  hostname: "your_db_host",
  port: "5432"
