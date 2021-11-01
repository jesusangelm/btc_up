defmodule BtcUp.InitialLoader do
  # TODO Corregir la forma en la que se ubica el archivo, Ver PATH en la documentacion
  @csv_datafile_path "/home/angel/Programacion/elixir/btc_up/lib/btc_price/BTCprice.csv"
  alias BtcUp.{Repo, Price}

  def read do
    File.stream!(@csv_datafile_path) |> CSV.decode(headers: true)
  end

  def show do
    read() |> Enum.map(fn {_ok, row} -> row end)
  end

  def move_to_db do
    data = read() |> Enum.map(fn {_ok, row} ->
      # conversion de string a fecha/float
      {:ok, date} = Date.from_iso8601(row["Date"])
      price = String.to_float(row["Price"])

      # adecuando los registros individuales para
      # que esten acorde a el schema de la DB.
      %{:day => date,
        :value => price,
        :inserted_at => NaiveDateTime.local_now,
        :updated_at => NaiveDateTime.local_now
      }
    end)
    # insert_all (y todos los *_all) no genera y agrega automaticamente
    # los timestamps (columnas insert_all/updated_at)
    # por eso se tuvieron que agregar en el map arriba.
    Repo.insert_all(Price, data)
  end
end
