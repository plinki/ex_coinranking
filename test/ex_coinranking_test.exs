defmodule CoinrankingTest do
  use ExUnit.Case
  doctest Coinranking

  test "single asset" do
    map = Coinranking.coin(1)
    assert is_integer(map.data.coin.totalSupply)
    assert is_integer(map.data.coin.circulatingSupply)
    assert is_integer(map.data.coin.marketCap)
    assert map.data.coin.symbol == "BTC"
  end

  test "all assets" do
    map = Coinranking.coins()
    assert map.status == "success"
    assert %{status: _, data: _} = map
  end

  test "asset history" do
    map = Coinranking.coin_history(1)
    assert map.status == "success"
    assert %{status: _, data: _} = map
  end

  test "global stats" do
    map = Coinranking.global_stats()
    assert is_float(map.data.total24hVolume)
    assert is_integer(map.data.totalCoins)
    assert is_integer(map.data.totalExchanges)
    assert is_float(map.data.totalMarketCap)
    assert is_integer(map.data.totalMarkets)
    assert map.status == "success"
    assert %{status: _, data: _} = map
  end

  test "markets" do
    map = Coinranking.markets()
    assert map.status == "success"
    assert %{status: _, data: _} = map
  end

  test "cryptocurrency exchanges" do
    map = Coinranking.exchanges()
    assert map.status == "success"
    assert %{status: _, data: _} = map
  end
end
