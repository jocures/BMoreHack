defmodule Gohireme.Repo.Migrations.AddPitchVideoUrlToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :pitch_video_url, :string
      add :hire_video_url, :string
    end
  end
end
