defmodule Gohireme.Accounts.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.User

  schema "candidates" do
    field :desired_industry, :string
    field :desired_job_title, :string
    field :first_name, :string
    field :last_name, :string
    field :location, :string
    field :salary_max, :integer
    field :salary_min, :integer
    field :desired_raise, :integer
    field :remote_ok, :boolean

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:user_id, :first_name, :last_name, :salary_min, :salary_max, :location, :desired_job_title, :desired_industry, :desired_raise, :remote_ok])
    |> validate_required([:first_name, :last_name])
    |> validate_number(:salary_min, greater_than: 0, less_than: :salary_max, message: "Can't be negative or more than max salary.")
    |> validate_number(:desired_raise, greater_than: 0, less_than: :salary_min, message: "Can't negative or more than annual salary.")
  end
end
