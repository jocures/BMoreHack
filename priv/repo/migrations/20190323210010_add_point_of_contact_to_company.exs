defmodule Gohireme.Repo.Migrations.AddPointOfContactToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :point_of_contact_first_name, :string
      add :point_of_contact_last_name, :string
      add :point_of_contact_phone, :string
      add :point_of_contact_email, :string
    end
  end
end
