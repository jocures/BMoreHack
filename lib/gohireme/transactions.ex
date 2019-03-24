defmodule Gohireme.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Gohireme.Repo

  alias Gohireme.Transactions.JobPosting


  @doc """
  Returns the list of job postings.

  ## Examples

      iex> list_job_postings()
      [%User{}, ...]

  """
  def list_job_postings do
    JobPosting
   |> Repo.all()
   |> Repo.preload(:company)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job posting changes.

  ## Examples

      iex> change_job_posting(job_posting)
      %Ecto.Changeset{source: %JobPosting{}}

  """
  def change_job_posting(%JobPosting{} = job_posting) do
    JobPosting.changeset(job_posting, %{})
  end

  @doc """
  Creates a job posting.

  ## Examples

      iex> create_job_posting(%{field: value})
      {:ok, %JobPosting{}}

      iex> create_job_posting(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job_posting(attrs \\ %{}) do
    %JobPosting{}
    |> JobPosting.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single job_posting.

  Raises `Ecto.NoResultsError` if the JobPosting does not exist.

  ## Examples

      iex> get_job_posting!(123)
      %JobPosting{}

      iex> get_job_posting!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job_posting!(id), do: Repo.get!(JobPosting, id)

  alias Gohireme.Transactions.Donation

  @doc """
  Returns the list of donations.

  ## Examples

      iex> list_donations()
      [%Donation{}, ...]

  """
  def list_donations do
    Repo.all(Donation)
  end

  def list_donations_for_candidate(candidate_id) do
    query = from d in Donation,
      where: d.candidate_id == ^candidate_id
    Repo.all(query)
  end

  @doc """
  Gets a single donation.

  Raises `Ecto.NoResultsError` if the Donation does not exist.

  ## Examples

      iex> get_donation!(123)
      %Donation{}

      iex> get_donation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_donation!(id), do: Repo.get!(Donation, id)

  @doc """
  Creates a donation.

  ## Examples

      iex> create_donation(%{field: value})
      {:ok, %Donation{}}

      iex> create_donation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_donation(attrs \\ %{}) do
    %Donation{}
    |> Donation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donation.

  ## Examples

      iex> update_donation(donation, %{field: new_value})
      {:ok, %Donation{}}

      iex> update_donation(donation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_donation(%Donation{} = donation, attrs) do
    donation
    |> Donation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Donation.

  ## Examples

      iex> delete_donation(donation)
      {:ok, %Donation{}}

      iex> delete_donation(donation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_donation(%Donation{} = donation) do
    Repo.delete(donation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donation changes.

  ## Examples

      iex> change_donation(donation)
      %Ecto.Changeset{source: %Donation{}}

  """
  def change_donation(%Donation{} = donation) do
    Donation.changeset(donation, %{})
  end
end
