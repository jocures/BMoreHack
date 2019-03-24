defmodule Gohireme.AccountsTest do
  use Gohireme.DataCase

  alias Gohireme.Accounts

  describe "users" do
    alias Gohireme.Accounts.User

    @valid_attrs %{email: "some email", encrypted_password: "some encrypted_password"}
    @update_attrs %{email: "some updated email", encrypted_password: "some updated encrypted_password"}
    @invalid_attrs %{email: nil, encrypted_password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.encrypted_password == "some encrypted_password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.encrypted_password == "some updated encrypted_password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "companies" do
    alias Gohireme.Accounts.Company

    @valid_attrs %{company_description: "some company_description", company_logo: "some company_logo", company_name: "some company_name", company_url: "some company_url"}
    @update_attrs %{company_description: "some updated company_description", company_logo: "some updated company_logo", company_name: "some updated company_name", company_url: "some updated company_url"}
    @invalid_attrs %{company_description: nil, company_logo: nil, company_name: nil, company_url: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Accounts.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Accounts.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Accounts.create_company(@valid_attrs)
      assert company.company_description == "some company_description"
      assert company.company_logo == "some company_logo"
      assert company.company_name == "some company_name"
      assert company.company_url == "some company_url"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Accounts.update_company(company, @update_attrs)
      assert company.company_description == "some updated company_description"
      assert company.company_logo == "some updated company_logo"
      assert company.company_name == "some updated company_name"
      assert company.company_url == "some updated company_url"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_company(company, @invalid_attrs)
      assert company == Accounts.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Accounts.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Accounts.change_company(company)
    end
  end

  describe "candidates" do
    alias Gohireme.Accounts.Candidate

    @valid_attrs %{desired_industry: "some desired_industry", desired_job_title: "some desired_job_title", first_name: "some first_name", last_name: "some last_name", location: "some location", salary_max: 42, salary_min: 42}
    @update_attrs %{desired_industry: "some updated desired_industry", desired_job_title: "some updated desired_job_title", first_name: "some updated first_name", last_name: "some updated last_name", location: "some updated location", salary_max: 43, salary_min: 43}
    @invalid_attrs %{desired_industry: nil, desired_job_title: nil, first_name: nil, last_name: nil, location: nil, salary_max: nil, salary_min: nil}

    def candidate_fixture(attrs \\ %{}) do
      {:ok, candidate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_candidate()

      candidate
    end

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Accounts.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Accounts.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      assert {:ok, %Candidate{} = candidate} = Accounts.create_candidate(@valid_attrs)
      assert candidate.desired_industry == "some desired_industry"
      assert candidate.desired_job_title == "some desired_job_title"
      assert candidate.first_name == "some first_name"
      assert candidate.last_name == "some last_name"
      assert candidate.location == "some location"
      assert candidate.salary_max == 42
      assert candidate.salary_min == 42
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{} = candidate} = Accounts.update_candidate(candidate, @update_attrs)
      assert candidate.desired_industry == "some updated desired_industry"
      assert candidate.desired_job_title == "some updated desired_job_title"
      assert candidate.first_name == "some updated first_name"
      assert candidate.last_name == "some updated last_name"
      assert candidate.location == "some updated location"
      assert candidate.salary_max == 43
      assert candidate.salary_min == 43
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_candidate(candidate, @invalid_attrs)
      assert candidate == Accounts.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Accounts.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Accounts.change_candidate(candidate)
    end
  end

  describe "donors" do
    alias Gohireme.Accounts.Donor

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name"}
    @invalid_attrs %{first_name: nil, last_name: nil}

    def donor_fixture(attrs \\ %{}) do
      {:ok, donor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_donor()

      donor
    end

    test "list_donors/0 returns all donors" do
      donor = donor_fixture()
      assert Accounts.list_donors() == [donor]
    end

    test "get_donor!/1 returns the donor with given id" do
      donor = donor_fixture()
      assert Accounts.get_donor!(donor.id) == donor
    end

    test "create_donor/1 with valid data creates a donor" do
      assert {:ok, %Donor{} = donor} = Accounts.create_donor(@valid_attrs)
      assert donor.first_name == "some first_name"
      assert donor.last_name == "some last_name"
    end

    test "create_donor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_donor(@invalid_attrs)
    end

    test "update_donor/2 with valid data updates the donor" do
      donor = donor_fixture()
      assert {:ok, %Donor{} = donor} = Accounts.update_donor(donor, @update_attrs)
      assert donor.first_name == "some updated first_name"
      assert donor.last_name == "some updated last_name"
    end

    test "update_donor/2 with invalid data returns error changeset" do
      donor = donor_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_donor(donor, @invalid_attrs)
      assert donor == Accounts.get_donor!(donor.id)
    end

    test "delete_donor/1 deletes the donor" do
      donor = donor_fixture()
      assert {:ok, %Donor{}} = Accounts.delete_donor(donor)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_donor!(donor.id) end
    end

    test "change_donor/1 returns a donor changeset" do
      donor = donor_fixture()
      assert %Ecto.Changeset{} = Accounts.change_donor(donor)
    end
  end
end
