defmodule Investir.Client.HTTP do
  @moduledoc """
  HTTP client to make REST api requests

  It's a wrapper around the Finch package
  """

  use Agent

  def init(config, client, pool_size) do
    Agent.start_link(
      fn ->
        %{
          config: config,
          client: client,
          pool_size: pool_size
        }
      end,
      name: __MODULE__
    )

    {
      Finch,
      name: client,
      pools: %{
        config[:url] => [size: pool_size]
      }
    }
  end

  def request(method, path) do
    config = get(:config)
    client = get(:client)

    method
    |> Finch.build("#{config.url}#{path}", headers())
    |> Finch.request(client)
  end

  def request(method, path, query: query) do
    config = get(:config)
    client = get(:client)

    url =
      URI.parse(config[:url])
      |> Map.merge(%{path: path, query: URI.encode_query(query)})
      |> to_string()

    method
    |> Finch.build(url, headers())
    |> Finch.request(client)
  end

  def request(method, path, query: query, headers: headers) do
    config = get(:config)
    client = get(:client)

    url =
      URI.parse(config[:url])
      |> Map.merge(%{path: path, query: URI.encode_query(query)})
      |> to_string()

    method
    |> Finch.build(url, headers(headers))
    |> Finch.request(client)
  end

  def request(method, path, query: query, headers: headers, body: body) do
    config = get(:config)
    client = get(:client)

    url =
      URI.parse(config[:url])
      |> Map.merge(%{path: path, query: URI.encode_query(query)})
      |> to_string()

    method
    |> Finch.build(url, headers(headers), body)
    |> Finch.request(client)
  end

  defp headers(other \\ []) do
    other
    # (get(:config)[:headers] || []) ++ other
  end

  defp get(key) do
    Agent.get(__MODULE__, & &1)
    |> Map.get(key)
  end
end
