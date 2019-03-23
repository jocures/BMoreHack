defmodule Gohireme.Repo.Migrations.AddRemoteOkToCandidate do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      add :remote_ok, :boolean, default: false
    end
  end
end
