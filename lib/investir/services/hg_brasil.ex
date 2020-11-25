defmodule Investir.Services.HgBrasil do
  @moduledoc """
  HTTP client to make requests with hgbrasil.com's REST API
  """

  alias Investir.Client.HTTP
  alias Finch.Response

  def pool_size, do: 10

  def child_spec() do
    config = Application.get_env(:investir, __MODULE__)
    HTTP.init(config, __MODULE__, pool_size())
  end

  def get(path, query \\ %{}) do
    :get
    |> HTTP.request(path, query: query, headers: headers())
    |> handle_response
  end

  def post(path, body \\ %{}) do
    json = body |> Jason.encode!()

    :post
    |> HTTP.request(path, query: %{}, headers: headers(), body: json)
    |> handle_response
  end

  def put(path, body \\ %{}) do
    json = body |> Jason.encode!()

    :put
    |> HTTP.request(path, query: %{}, headers: headers(), body: json)
    |> handle_response
  end

  defp handle_response({:ok, %Response{body: body, status: status}}) do
    case status do
      200 -> {:ok, %{body: Jason.decode!(body), status: status}}
      201 -> {:ok, %{body: Jason.decode!(body), status: status}}
      202 -> {:ok, %{body: %{}, status: status}}
      404 -> {:error, %{body: %{"message" => "not found"}, status: status}}
      _ -> {:error, %{body: Jason.decode!(body), status: status}}
    end
  end

  defp headers do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/json"}
    ]
  end
end
