defmodule BtcUp.MixProject do
  use Mix.Project

  def project do
    [
      app: :btc_up,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {BtcUp.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, "~> 2.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, "~> 0.15.9"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:quantum, "~> 3.4"}
    ]
  end
end
