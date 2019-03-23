defmodule Gohireme.Repo.Migrations.AddRaiseAmountToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :desired_raise, :integer
    end
  end
end
