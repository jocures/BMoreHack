defmodule Gohireme.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.User

  schema "companies" do
    field :company_description, :string
    field :company_logo, :string
    field :company_name, :string
    field :company_url, :string
    field :contact_info, :string
    field :mission, :string
    field :size, :string
    field :industry, :string
    field :location, :string
    field :point_of_contact_first_name, :string
    field :point_of_contact_last_name, :string
    field :point_of_contact_phone, :string
    field :point_of_contact_email, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:user_id, :company_name, :company_description, :company_url, :company_logo,
    :contact_info, :mission, :size,  :industry, :location, :point_of_contact_first_name,
    :point_of_contact_last_name, :point_of_contact_phone, :point_of_contact_email])
    |> validate_required([:user_id, :company_name, :company_description, :company_url])
  end
end
