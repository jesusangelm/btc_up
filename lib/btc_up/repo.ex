defmodule BtcUp.Repo do
  use Ecto.Repo,
    otp_app: :btc_up,
    adapter: Ecto.Adapters.Postgres

  # No obligatoria, solo la coloque como un modo de prueba
  def using_postgres? do
    BtcUp.Repo.__adapter__ == Ecto.Adapters.Postgres
  end
end
