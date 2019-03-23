defmodule Gohireme.Repo.Migrations.MakeStoryTypeText do
  use Ecto.Migration

  def change do
    alter table(:candidates) do
      modify :story, :text
    end
  end
end
