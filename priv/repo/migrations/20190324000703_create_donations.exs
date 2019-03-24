defmodule Gohireme.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  alias Gohireme.Accounts.Candidate
  alias Gohireme.Accounts.Donor

  def change do
    create table(:donations) do
      add :amount, :integer
      add :donor_id, references(:donors, on_delete: :delete_all)
      add :candidate_id, references(:candidates, on_delete: :delete_all)

      timestamps()
    end

    create index(:donations, [:donor_id])
    create index(:donations, [:candidate_id])
  end
end
