# Este archivo y carpeta no lo genera mix por defecto
# Mix.Config fue deprecado en favor de Config
# A continuacion se usa la configuracion con el nuevo modulo
import Config

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :btc_up, BtcUp.Scheduler,
  jobs: [
    # Todos los dias a las 8PM UTC (Quantum usa UTC) 4PM VET
    {"0 20 * * *", {BtcUp.DailyUpdater, :run, []}}
  ]
