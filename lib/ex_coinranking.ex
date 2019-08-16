defmodule Excoinranking do
  use HTTPoison.Base
  use Poison

  @base_url "https://api.coinranking.com/v1/public/"

  HTTPoison.start()

  def get(data) do
    case HTTPoison.get(@base_url <> data) do
      {:ok, %HTTPoison.Response{status_code: code, body: body}} ->
        {code, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts(":(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
    |> fn {ok, body} ->
      body
      |> Poison.decode(keys: :atoms)
      |> case do
        {:ok, parsed} -> {ok, parsed}
        _ -> {:error, body}
      end
    end
  end

  def get_coins do
    get("coins")
  end

  def get_coin_by_id(id) do
    get("coin/#{id}")
  end
end
