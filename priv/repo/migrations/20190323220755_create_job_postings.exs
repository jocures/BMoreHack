defmodule Gohireme.Repo.Migrations.CreateJobPostings do
  use Ecto.Migration

  def change do
    create table(:job_postings) do
      add :title, :string
      add :deadline, :date
      add :link, :string
      add :salary_max, :integer
      add :salary_min, :integer
      add :company_id, references(:companies)

      timestamps()
    end
  end
end
