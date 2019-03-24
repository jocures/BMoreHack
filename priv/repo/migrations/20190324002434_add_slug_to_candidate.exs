defmodule Gohireme.Repo.Migrations.AddSlugToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :slug, :string
    end
  end
end
