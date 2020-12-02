defmodule Investir.DeepValueInvestingTest do
  use Investir.DataCase

  alias Investir.DeepValueInvesting

  describe "organizations" do
    alias Investir.DeepValueInvesting.Organization

    @valid_attrs %{code: "some code", ev_ebi: 120.5, net_margin: 120.5, net_worth: 120.5, quotation: 120.5, variation: 120.5}
    @update_attrs %{code: "some updated code", ev_ebi: 456.7, net_margin: 456.7, net_worth: 456.7, quotation: 456.7, variation: 456.7}
    @invalid_attrs %{code: nil, ev_ebi: nil, net_margin: nil, net_worth: nil, quotation: nil, variation: nil}

    def organization_fixture(attrs \\ %{}) do
      {:ok, organization} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DeepValueInvesting.create_organization()

      organization
    end

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert DeepValueInvesting.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert DeepValueInvesting.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      assert {:ok, %Organization{} = organization} = DeepValueInvesting.create_organization(@valid_attrs)
      assert organization.code == "some code"
      assert organization.ev_ebi == 120.5
      assert organization.net_margin == 120.5
      assert organization.net_worth == 120.5
      assert organization.quotation == 120.5
      assert organization.variation == 120.5
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DeepValueInvesting.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{} = organization} = DeepValueInvesting.update_organization(organization, @update_attrs)
      assert organization.code == "some updated code"
      assert organization.ev_ebi == 456.7
      assert organization.net_margin == 456.7
      assert organization.net_worth == 456.7
      assert organization.quotation == 456.7
      assert organization.variation == 456.7
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = DeepValueInvesting.update_organization(organization, @invalid_attrs)
      assert organization == DeepValueInvesting.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = DeepValueInvesting.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> DeepValueInvesting.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = DeepValueInvesting.change_organization(organization)
    end
  end
end
