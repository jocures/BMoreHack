defmodule Gohireme.Repo.Migrations.AddProfileImageToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :profile_image, :string
    end
  end
end
