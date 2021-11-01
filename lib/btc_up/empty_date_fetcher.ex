defmodule BtcUp.EmptyDateFetcher do
  require Logger
  alias BtcUp.{Repo, Price}

  def run(start_date_string, end_date_string) do
    {:ok, start_date} = Date.from_iso8601(start_date_string)
    {:ok, end_date} = Date.from_iso8601(end_date_string)
    date_range = Date.range(start_date, end_date)
    Logger.info("Se procede a trabajar con el rango: #{inspect date_range}")

    date_range
    |> Enum.each(&updater/1)
  end

  defp updater(date) do
    Logger.info("Solicitando precio para: #{inspect date}")
    BtcUp.FetcherServer.price_by_date(date)

    [{date, price}] =
      BtcUp.FetcherServer.get_price()
      |> Map.to_list()

    Logger.info("Obtenido datos: Precio: #{inspect price} | Fecha: #{inspect date}")
    {:ok, date} = Date.from_iso8601(date)
    
    payload = %Price{
      :day => date,
      :value => price
    }
    
    Logger.debug("Payload: #{inspect payload}")
    Repo.insert(payload)
    Logger.info("Esperando 30seg para la siguiente fecha...")
    :timer.sleep(30000)
  end
end
