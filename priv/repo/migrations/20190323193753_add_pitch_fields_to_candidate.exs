defmodule Gohireme.Repo.Migrations.AddPitchFieldsToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :pitch, :string
      add :story, :string
      add :linked_in_url, :string
      add :personal_website, :string
    end
  end
end
