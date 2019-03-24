defmodule Gohireme.TransactionsTest do
  use Gohireme.DataCase

  alias Gohireme.Transactions

  describe "donations" do
    alias Gohireme.Transactions.Donation

    @valid_attrs %{amount: 42}
    @update_attrs %{amount: 43}
    @invalid_attrs %{amount: nil}

    def donation_fixture(attrs \\ %{}) do
      {:ok, donation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_donation()

      donation
    end

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert Transactions.list_donations() == [donation]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert Transactions.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      assert {:ok, %Donation{} = donation} = Transactions.create_donation(@valid_attrs)
      assert donation.amount == 42
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{} = donation} = Transactions.update_donation(donation, @update_attrs)
      assert donation.amount == 43
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_donation(donation, @invalid_attrs)
      assert donation == Transactions.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = Transactions.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = Transactions.change_donation(donation)
    end
  end
end
