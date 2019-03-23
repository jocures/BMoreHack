defmodule Gohireme.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Argon2

  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :encrypted_password_confirmation, :string, virtual: true

    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :encrypted_password, :role])
    |> validate_required([:email, :encrypted_password, :role])
    |> unique_constraint(:email)
    |> validate_inclusion(:role, ["candidate", "employer", "donor"])
    |> validate_confirmation(:encrypted_password, message: "Passwords do not match.")
    |> update_change(:encrypted_password, &Argon2.hash_pwd_salt/1)
  end
end
