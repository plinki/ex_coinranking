defmodule ExCoinranking.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_coinranking,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),

      # ex_doc
      name: "Coinranking",
      source_url: "https://github.com/SplendidX/ex_coinranking",
      docs: [
        main: "Coinranking",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.5"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    An Elixir wrapper for the Coinranking API, using HTTPoison and Poison.
    """
  end

  defp package do
    [
      files: ["lib", ".formatter.exs", "mix.exs", "README*", "LICENSE*"],
      licenses: ["GPL 3.0"],
      links: %{
        "GitHub" => "https://github.com/SplendidX/ex_coinranking"
      }
    ]
  end
end
