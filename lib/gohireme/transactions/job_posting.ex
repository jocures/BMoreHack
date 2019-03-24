defmodule Gohireme.Transactions.JobPosting do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.Company

  schema "job_postings" do
    field :title, :string
    field :deadline, :date
    field :link, :string
    field :salary_max, :integer
    field :salary_min, :integer
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:title, :deadline, :link, :salary_min, :salary_max, :company_id])
    |> validate_required([:title, :deadline, :link, :salary_min, :salary_max, :company_id])
  end
end
