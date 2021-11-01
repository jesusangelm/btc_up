defmodule BtcUp.Fetcher do
  require Logger
  # @ticker 'BTCUSDT'
  # "https://api.binance.com/api/v3/ticker/price?symbol=#{ticker}"
  @user_agent [{"User-agent", "Necris 6.6.6"}]

  def fetch_yesterday do
    url_gen()
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def fetch_custom(date) do
    url_gen(date)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  defp url_gen do
    yesterday_date_string = Date.utc_today() |> Date.add(-1) |> Date.to_string()
    "https://api.coindesk.com/v1/bpi/historical/close.json?start=#{yesterday_date_string}&end=#{yesterday_date_string}"
  end

  defp url_gen(date) do
    date_string = date |> Date.to_string()
    "https://api.coindesk.com/v1/bpi/historical/close.json?start=#{date_string}&end=#{date_string}"
  end

  defp handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error,
      body |> Jason.decode!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
