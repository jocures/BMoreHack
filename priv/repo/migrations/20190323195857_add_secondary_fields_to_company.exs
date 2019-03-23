defmodule Gohireme.Repo.Migrations.AddSecondaryFieldsToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :contact_info, :string
      add :mission, :string
      add :size, :string
      add :industry, :string
      add :location, :string
    end
  end
end
