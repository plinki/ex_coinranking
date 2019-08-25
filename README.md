# ex_coinranking

An Elixir wrapper for the Coinranking API, using HTTPoison and Poison.

example:
```
iex(1)> bitcoin = Coinranking.coin(1, %{base: "EUR", timePeriod: "30d"})

iex(2)> bitcoin.data.coin.description
"Bitcoin is the first decentralized digital currency that can be sent through the internet globally without using financial institutions like banks. The network is controlled by many of its users, instead of a few entities."
```

Coinranking API Documentation: https://docs.coinranking.com/public
