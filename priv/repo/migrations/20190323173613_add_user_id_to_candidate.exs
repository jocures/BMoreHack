defmodule Gohireme.Repo.Migrations.AddUserIdToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :user_id, references(:users)
    end
  end
end
