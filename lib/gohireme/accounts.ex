defmodule Gohireme.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Gohireme.Repo

  alias Gohireme.Accounts.User
  alias Gohireme.Accounts.Company
  alias Gohireme.Accounts.Candidate

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)
  
  @doc """
  Gets a user by their email address.

  ## Examples
  
      iex> get_user_by_email("user@example.com")
      %User{email: "user@example.com"}

      iex> get_user_by_email("notuser@example.com")
      nil
  """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Returns the user supertype (Candidate or Company) from their user id.
  """
  def get_user_type(nil), do: nil

  def get_user_type(user_id) do
    case get_company_for_user(user_id) do
      %Company{} = company -> company
      _ ->
        case get_candidate_for_user(user_id) do
          %Candidate{} = candidate -> candidate
          _ -> nil
        end
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of companies.

  ## Examples

      iex> list_companies()
      [%Company{}, ...]

  """
  def list_companies do
    Repo.all(Company)
  end

  @doc """
  Gets a single company.

  Raises `Ecto.NoResultsError` if the Company does not exist.

  ## Examples

      iex> get_company!(123)
      %Company{}

      iex> get_company!(456)
      ** (Ecto.NoResultsError)

  """
  def get_company!(id), do: Repo.get!(Company, id)

  @doc """
  Creates a company.

  ## Examples

      iex> create_company(%{field: value})
      {:ok, %Company{}}

      iex> create_company(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a company.

  ## Examples

      iex> update_company(company, %{field: new_value})
      {:ok, %Company{}}

      iex> update_company(company, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Company.

  ## Examples

      iex> delete_company(company)
      {:ok, %Company{}}

      iex> delete_company(company)
      {:error, %Ecto.Changeset{}}

  """
  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking company changes.

  ## Examples

      iex> change_company(company)
      %Ecto.Changeset{source: %Company{}}

  """
  def change_company(%Company{} = company) do
    Company.changeset(company, %{})
  end

  @doc """
  Gets a company by a user's id.

  ## Examples

      iex> get_company_for_user(1)
      %Company{user_id: 1}

      iex> get_company_for_user(200)
      nil
  """
  def get_company_for_user(user_id) do
    Repo.get_by(Company, user_id: user_id)
  end

  @doc """
  Returns the list of candidates.

  ## Examples

      iex> list_candidates()
      [%Candidate{}, ...]

  """
  def list_candidates do
    Repo.all(Candidate)
  end

  @doc """
  Gets a single candidate.

  Raises `Ecto.NoResultsError` if the Candidate does not exist.

  ## Examples

      iex> get_candidate!(123)
      %Candidate{}

      iex> get_candidate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_candidate!(id), do: Repo.get!(Candidate, id)

  @doc """
  Gets a candidate by their user id.

  ## Examples

      iex> get_candidate_for_user(1)
      %Candidate{user_id: 1}

      iex> get_candidate_for_user(200)
      nil
  """
  def get_candidate_for_user(user_id) do
    Repo.get_by(Candidate, user_id: user_id)
  end

  def get_candidate_by_slug(slug) do
    Repo.get_by(Candidate, slug: slug)
  end

  @doc """
  Creates a candidate.

  ## Examples

      iex> create_candidate(%{field: value})
      {:ok, %Candidate{}}

      iex> create_candidate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  defp random_hash() do
    :crypto.strong_rand_bytes(16)
    |> Base.encode16()
    |> String.slice(0, 8)
  end

  def create_candidate(attrs \\ %{}) do
    slug = 
      "#{attrs["first_name"]}-#{attrs["last_name"]}-#{random_hash()}"
      |> String.downcase()
    %Candidate{}
    |> Candidate.changeset(Map.put(attrs, "slug", slug))
    |> Repo.insert()
  end

  @doc """
  Updates a candidate.

  ## Examples

      iex> update_candidate(candidate, %{field: new_value})
      {:ok, %Candidate{}}

      iex> update_candidate(candidate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_candidate(%Candidate{} = candidate, attrs) do
    candidate
    |> Candidate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Candidate.

  ## Examples

      iex> delete_candidate(candidate)
      {:ok, %Candidate{}}

      iex> delete_candidate(candidate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_candidate(%Candidate{} = candidate) do
    Repo.delete(candidate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking candidate changes.

  ## Examples

      iex> change_candidate(candidate)
      %Ecto.Changeset{source: %Candidate{}}

  """
  def change_candidate(%Candidate{} = candidate) do
    Candidate.changeset(candidate, %{})
  end

  alias Gohireme.Accounts.Donor

  @doc """
  Returns the list of donors.

  ## Examples

      iex> list_donors()
      [%Donor{}, ...]

  """
  def list_donors do
    Repo.all(Donor)
  end

  @doc """
  Gets a single donor.

  Raises `Ecto.NoResultsError` if the Donor does not exist.

  ## Examples

      iex> get_donor!(123)
      %Donor{}

      iex> get_donor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_donor!(id), do: Repo.get!(Donor, id)

  @doc """
  Creates a donor.

  ## Examples

      iex> create_donor(%{field: value})
      {:ok, %Donor{}}

      iex> create_donor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_donor(attrs \\ %{}) do
    %Donor{}
    |> Donor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donor.

  ## Examples

      iex> update_donor(donor, %{field: new_value})
      {:ok, %Donor{}}

      iex> update_donor(donor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_donor(%Donor{} = donor, attrs) do
    donor
    |> Donor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Donor.

  ## Examples

      iex> delete_donor(donor)
      {:ok, %Donor{}}

      iex> delete_donor(donor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_donor(%Donor{} = donor) do
    Repo.delete(donor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donor changes.

  ## Examples

      iex> change_donor(donor)
      %Ecto.Changeset{source: %Donor{}}

  """
  def change_donor(%Donor{} = donor) do
    Donor.changeset(donor, %{})
  end
end
