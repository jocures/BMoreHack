defmodule Gohireme.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.User

  schema "companies" do
    field :company_description, :string
    field :company_logo, :string
    field :company_name, :string
    field :company_url, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:user_id, :company_name, :company_description, :company_url, :company_logo])
    |> validate_required([:user_id, :company_name, :company_description, :company_url])
  end
end
