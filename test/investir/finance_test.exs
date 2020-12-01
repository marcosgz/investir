defmodule Investir.FinanceTest do
  use Investir.DataCase

  alias Investir.Finance

  describe "finance_overviews" do
    alias Investir.Finance.Overview

    @valid_attrs %{available_sources: [], bitcoins: [], currencies: [], stocks: [], taxes: []}
    @update_attrs %{available_sources: [], bitcoins: [], currencies: [], stocks: [], taxes: []}
    @invalid_attrs %{
      available_sources: nil,
      bitcoins: nil,
      currencies: nil,
      stocks: nil,
      taxes: nil
    }

    def overview_fixture(attrs \\ %{}) do
      {:ok, overview} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Finance.create_overview()

      overview
    end

    test "list_finance_overviews/0 returns all finance_overviews" do
      overview = overview_fixture()
      assert Finance.list_finance_overviews() == [overview]
    end

    test "get_overview!/1 returns the overview with given id" do
      overview = overview_fixture()
      assert Finance.get_overview!(overview.id) == overview
    end

    test "create_overview/1 with valid data creates a overview" do
      assert {:ok, %Overview{} = overview} = Finance.create_overview(@valid_attrs)
      assert overview.available_sources == []
      assert overview.bitcoins == []
      assert overview.currencies == []
      assert overview.stocks == []
      assert overview.taxes == []
    end

    test "create_overview/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_overview(@invalid_attrs)
    end

    test "update_overview/2 with valid data updates the overview" do
      overview = overview_fixture()
      assert {:ok, %Overview{} = overview} = Finance.update_overview(overview, @update_attrs)
      assert overview.available_sources == []
      assert overview.bitcoins == []
      assert overview.currencies == []
      assert overview.stocks == []
      assert overview.taxes == []
    end

    test "update_overview/2 with invalid data returns error changeset" do
      overview = overview_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_overview(overview, @invalid_attrs)
      assert overview == Finance.get_overview!(overview.id)
    end

    test "delete_overview/1 deletes the overview" do
      overview = overview_fixture()
      assert {:ok, %Overview{}} = Finance.delete_overview(overview)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_overview!(overview.id) end
    end

    test "change_overview/1 returns a overview changeset" do
      overview = overview_fixture()
      assert %Ecto.Changeset{} = Finance.change_overview(overview)
    end
  end
end
