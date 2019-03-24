defmodule Gohireme.Repo.Migrations.MakeCompanyStringsText do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      modify :company_description, :text
    end
  end
end
