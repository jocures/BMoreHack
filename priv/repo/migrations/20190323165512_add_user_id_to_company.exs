defmodule Gohireme.Repo.Migrations.AddUserIdToCompany do
  use Ecto.Migration

  def change do
    alter table(:companies) do
      add :user_id, references(:users)
    end
  end
end
