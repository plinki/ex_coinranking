# ExCoinranking

An Elixir wrapper for the Coinranking API, using HTTPoison and Poison.

example: ```coin(1, %{base: "USD", timePeriod: "30d"})```

Coinranking API Documentation: https://docs.coinranking.com/public

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_coinranking` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_coinranking, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_coinranking](https://hexdocs.pm/ex_coinranking).

