defmodule Gohireme.Repo.Migrations.CreateDonors do
  use Ecto.Migration

  alias Gohireme.Accounts.User

  def change do
    create table(:donors) do
      add :first_name, :string
      add :last_name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:donors, [:user_id])
  end
end
