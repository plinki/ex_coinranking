defmodule Coinranking do
  @moduledoc """
  An Elixir wrapper for the Coinranking API, using HTTPoison and Poison.

  ```example: coin(1, %{base: "USD", timePeriod: "30d"})```

  Coinranking API Documentation: https://docs.coinranking.com/public
  """

  alias HTTPoison
  alias Poison

  HTTPoison.start()

  @doc """
  GET request
  Returns an HTTPoison response
  """
  @spec get(String.t(), map) :: {atom, map}
  def get(data, params \\ %{}) do
    HTTPoison.get(base_url(:ex_coinranking) <> data, [{"Content-Type", "application/json"}],
      params: params
    )
  end

  @doc """
  GET request
  Returns response body with keys as atoms
  """
  @spec get!(String.t(), map) :: map
  def get!(data, params \\ %{}) do
    case HTTPoison.get(base_url(:ex_coinranking) <> data, [{"Content-Type", "application/json"}],
           params: params
         ) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        {code, body}

      {:error, %HTTPoison.Error{} = error} ->
        error

      {_, msg} ->
        msg.body |> Poison.decode!()
    end
    |> (fn {_ok, body} ->
          body
          |> Poison.decode(keys: :atoms)
          |> case do
            {:ok, parsed} ->
              parsed

            _ ->
              {:error, body}
          end
        end).()
  end

  @spec base_url(atom) :: String.t()
  defp base_url(config) do
    base = Application.get_env(config, :base)
    ver = Application.get_env(config, :ver)

    "#{base}v#{ver}/public/"
  end

  @doc """
  List all coins with data - paginated by 50.
  ```
  %{param: "value"}
  param {string} params.base [default: USD] - Base currency
  param {string} params.timePeriod [default: 24h] - Time period where the change and history are based on
  param {string} params.prefix - Search to filter the list on. Only one of prefix, symbols, slugs or IDs parameters can be used at once
  param {string} params.symbols - Symbols to filter the list on. Separated by comma. Only one of prefix, symbols, slugs or IDs parameters can be used at once
  param {string} params.slugs - Slugs to filter the list on. Separated by comma. Only one of prefix, symbols, slugs or IDs parameters can be used at once
  param {string} params.ids - IDs to filter the list on. Separated by comma. Only one of prefix, symbols, slugs or IDs parameters can be used at once
  param {string} params.sort [default: coinranking] - Index to sort on. Default is Coinranking which takes the penalties in account
  param {string|number} params.limit [default: 50] - Limit. Used for pagination. Range: 0-100
  param {string|number} params.offset [default: 0] - Offset. Used for pagination
  param {string} params.order [default: desc] - Sort in ascending or descending order
  ```
  """
  def coins(params \\ %{}) do
    get!("coins", params)
  end

  @doc """
  Get current data for a single asset.
  ```
  %{param: "value"}
  param {string|number} id - ID of the coin you want to request
  param {string} params.base [default: USD] - Base currency
  param {string} params.timePeriod [default: 24h]- Time period where the change and history are based on
  ```
  """
  def coin(id, params \\ %{}) do
    get!("coin/#{id}", params)
  end

  @doc """
  Get pricing history for a single asset.
  ```
  %{param: "value"}
  param {string|number} id - ID of the coin you want to request
  param {string} params.base [default: USD] - Base currency
  param {string} params.timeframe [default: 24h]- Time frame where the change and history are based on
  ```
  """
  def coin_history(id, timeframe \\ "24h", params \\ %{}) do
    get!("coin/#{id}/history/#{timeframe}", params)
  end

  @doc """
  Get global stats
  ```
  param {string} params.base [default: USD] - Base currency
  ```
  """
  def global_stats(params \\ %{}) do
    get!("stats", params)
  end

  @doc """
  List all markets for currencies - paginated by 50
  ```
  param {string|number} params.refCurrencyId [default: 1509] - Id of currency in which prices are calculated, defaults to USD
  param {string|number} params.currencyId - Filter markets with specific currency as either base or quote.
    Specifying a currencyId will also alter how prices are shown:
    By default all the markets will show the price of the base in the refCurrency (e.g. an ETH/BTC market will show the price of ETH).
    By specifying a currencyId the prices of this currency will always be shown, disregarding whether or not this currency represents the base or the quote in the market
    (e.g. by specifying BTC as currency, both ETH/BTC as BTC/USD markets will show prices of BTC)
  param {string} params.toCurrencyId - Filter markets with specific currency as either base or quote. The toCurrencyId will not alter how the prices will be shown,
    but will keep the base price. This can be combined with the currencyId variable to get specific markets.
  param {string} params.baseCurrencyId - Filter markets with specific currency as base
  param {string} params.quoteCurrencyId - Filter markets with specific currency as quote
  param {string} params.sourceId - Filter markets from specific source
  param {string|number} params.limit [default: 50] - Limit. Used for pagination. Range: 0-100
  param {string|number} params.offset [default: 0] - Offset. Used for pagination
  param {string} params.order [default: volume] - Sort by either volume or price.
  param {string} params.orderDirection [default: desc] - Sort in ascending or descending order
  ```
  """
  def markets(params \\ %{}) do
    get!("markets", params)
  end

  @doc """
  ```
  param {string|number} params.refCurrencyId [default: 1509] - Id of currency in which prices are calculated, defaults to USD
  param {string|number} params.limit [default: 50] - Limit. Used for pagination. Range: 0-100
  param {string|number} params.offset [default: 0] - Offset. Used for pagination
  param {string} params.order [default: volume] - Sort by either volume, price, numberOfMarkets or lastTickerCreatedAt
  param {string} params.orderDirection [default: desc] - Sort in ascending or descending order
  param {string|number} params.currencyId - Filter exchanges with a specific currency. The exchanges shown will support the specific currency
    and Coinranking will have markets of these currencies. The price will be passed down when this paramater is set.
    ```
  """
  def exchanges(params \\ %{}) do
    get!("exchanges", params)
  end
end
