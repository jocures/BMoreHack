defmodule Gohireme.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :company_name, :string
      add :company_description, :string
      add :company_url, :string
      add :company_logo, :string

      timestamps()
    end

  end
end
