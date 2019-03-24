defmodule Gohireme.Transactions.Donation do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.Candidate
  alias Gohireme.Accounts.Donor

  schema "donations" do
    field :amount, :integer
    belongs_to :donor, Donor
    belongs_to: :candidate, Candidate

    timestamps()
  end

  @doc false
  def changeset(donation, attrs) do
    donation
    |> cast(attrs, [:amount, :donor_id, :candidate_id])
    |> validate_required([:amount, :donor_id, :candidate_id])
  end
end
