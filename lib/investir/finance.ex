defmodule Investir.Finance do
  @moduledoc """
  The Finance context.
  """

  import Ecto.Query, warn: false
  alias Investir.Repo

  alias Investir.Finance.Overview

  def latest_overview do
    Repo.one(from q in Overview, order_by: [desc: q.inserted_at], limit: 1)
  end

  @doc """
  Returns the list of finance_overviews.

  ## Examples

      iex> list_finance_overviews()
      [%Overview{}, ...]

  """
  def list_finance_overviews do
    Repo.all(Overview)
  end

  @doc """
  Gets a single overview.

  Raises `Ecto.NoResultsError` if the Overview does not exist.

  ## Examples

      iex> get_overview!(123)
      %Overview{}

      iex> get_overview!(456)
      ** (Ecto.NoResultsError)

  """
  def get_overview!(id), do: Repo.get!(Overview, id)

  @doc """
  Creates a overview.

  ## Examples

      iex> create_overview(%{field: value})
      {:ok, %Overview{}}

      iex> create_overview(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_overview(attrs \\ %{}) do
    %Overview{}
    |> Overview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a overview.

  ## Examples

      iex> update_overview(overview, %{field: new_value})
      {:ok, %Overview{}}

      iex> update_overview(overview, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_overview(%Overview{} = overview, attrs) do
    overview
    |> Overview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a overview.

  ## Examples

      iex> delete_overview(overview)
      {:ok, %Overview{}}

      iex> delete_overview(overview)
      {:error, %Ecto.Changeset{}}

  """
  def delete_overview(%Overview{} = overview) do
    Repo.delete(overview)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking overview changes.

  ## Examples

      iex> change_overview(overview)
      %Ecto.Changeset{data: %Overview{}}

  """
  def change_overview(%Overview{} = overview, attrs \\ %{}) do
    Overview.changeset(overview, attrs)
  end
end
