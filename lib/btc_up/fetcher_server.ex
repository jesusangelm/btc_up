defmodule BtcUp.FetcherServer do
  @name :FetcherServer
  use GenServer
  require Logger
  alias BtcUp.Fetcher

  # ______Cliente____________

  def start_link(_arg) do
    Logger.info("Iniciando el Servidor FetcherServer")
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def get_price do
    GenServer.call(@name, :get_price)
  end

  def refresh do
    GenServer.cast(@name, :refresh)
  end

  def price_by_date(date) do
    GenServer.cast(@name, {:by_date, date})
  end


  # _________Implementacion GenServer________________

  def init(_state) do
    {:ok, run_fetcher()}
  end

  def handle_call(:get_price, _from, state) do
    {:ok, %{"bpi" => response}} = state
    {:reply, response, state}
  end

  def handle_cast(:refresh, _state) do
    new_state = run_fetcher()
    {:noreply, new_state}
  end

  def handle_cast({:by_date, date}, _state) do
    new_state = Fetcher.fetch_custom(date)
    {:noreply, new_state}
  end

  defp run_fetcher do
    # colocado en un task para asi agilizar/acelerar la inicializacion del 
    # proceso GenServer, ya que lo primero que se hace en el init es llamar
    # a Fetcher.fetch y esto genera una request a la API que toma tiempo en
    # ser respondida.
    task = Task.async(fn -> Fetcher.fetch_yesterday() end)
    Task.await(task)
  end
end
