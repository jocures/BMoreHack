defmodule Gohireme.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :first_name, :string
      add :last_name, :string
      add :salary_min, :integer
      add :salary_max, :integer
      add :location, :string
      add :desired_job_title, :string
      add :desired_industry, :string

      timestamps()
    end

  end
end
