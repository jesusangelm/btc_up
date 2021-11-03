defmodule BtcUp.DailyUpdater do
  alias BtcUp.{Repo, Price}

  # TODO Agregar una verificacion para asegurarse de que el precio para una fecha a consultar
  # no exista ya en Base de Dato
  def run do
    BtcUp.FetcherServer.refresh()
    [{date, price}] =
      BtcUp.FetcherServer.get_price()
      |> Map.to_list()

    {:ok, date} = Date.from_iso8601(date)

    # Al usar el Schema Price (una Struc)
    # se genera automaticamente el id y el inserted_at y updated_at
    payload = %Price{
      :day => date,
      :value => price,
    }

    Repo.insert(payload)
  end
end
