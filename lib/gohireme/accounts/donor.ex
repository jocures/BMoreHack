defmodule Gohireme.Accounts.Donor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.User

  schema "donors" do
    field :first_name, :string
    field :last_name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(donor, attrs) do
    donor
    |> cast(attrs, [:first_name, :last_name, :user_id])
    |> validate_required([:first_name, :last_name, :user_id])
  end
end
