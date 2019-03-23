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
    Repo.all(JobPosting)
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
end
