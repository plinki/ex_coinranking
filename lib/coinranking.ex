defmodule Coinranking do
  @moduledoc """
    An Elixir wrapper for the Coinranking API, using HTTPoison and Poison.
    example: coin(1, %{base: "USD", timePeriod: "30d"})

    Coinranking API Documentation: https://docs.coinranking.com/public
  """

  use HTTPoison.Base
  alias Poison

  HTTPoison.start()

  @spec get(String.t(), map) :: {atom, map}
  def get(data, query_params \\ %{}) do
    HTTPoison.get(base_url(:ex_coinranking) <> data, [{"Content-Type", "application/json"}],
      params: query_params
    )
  end

  @spec get!(String.t(), map) :: map
  def get!(data, query_params \\ %{}) do
    case HTTPoison.get(base_url(:ex_coinranking) <> data, [{"Content-Type", "application/json"}],
           params: query_params
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

  def coins(query_params \\ %{}) do
    get!("coins", query_params)
  end

  def coin(id, query_params \\ %{}) do
    get!("coin/#{id}", query_params)
  end

  def coin_history(id, timeframe \\ "24h", query_params \\ %{}) do
    get!("coin/#{id}/history/#{timeframe}", query_params)
  end

  def global_stats(query_params \\ %{}) do
    get!("stats", query_params)
  end

  def markets(query_params \\ %{}) do
    get!("markets", query_params)
  end

  def exchanges(query_params \\ %{}) do
    get!("exchanges", query_params)
  end

  @spec base_url(atom) :: String.t()
  defp base_url(config) do
    base = Application.get_env(config, :base)
    ver = Application.get_env(config, :ver)

    "#{base}v#{ver}/public/"
  end
end
