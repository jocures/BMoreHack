defmodule GohiremeWeb.DonateController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.User
  alias Gohireme.Accounts.Donor
  alias Gohireme.Transactions
  alias Gohireme.Transactions.Donation

  def new(conn, %{"slug" => slug}) do
    candidate = Accounts.get_candidate_by_slug(slug)
    if is_nil(candidate), do: redirect(conn, Routes.page_path(conn, :index))
    total_donations =
      Transactions.list_donations_for_candidate(candidate.id)
      |> Enum.map(&(&1.amount))
      |> Enum.sum()

    render(conn, "new.html", candidate: candidate, total_donations: total_donations)
  end

  def create(conn, %{"slug" => slug, "amount" => amount, "email" => email, "first_name" => first_name, "last_name" => last_name}) do
    candidate = Accounts.get_candidate_by_slug(slug)
    # Money should be an integer. And in cents. Don't play yourself.
    amount = String.to_integer(amount) * 100
    with {:ok, %User{} = user} <- Accounts.create_user(%{email: email, encrypted_password: "password", encrypted_password: "password", role: "donor"}),
         {:ok, %Donor{} = donor} <- Accounts.create_donor(%{first_name: first_name, last_name: last_name, user_id: user.id}),
         {:ok, %Donation{}} <- Transactions.create_donation(%{donor_id: donor.id, candidate_id: candidate.id, amount: amount}) do
      redirect(conn, to: Routes.donate_path(conn, :show, slug))
    else
      _ -> redirect(conn, to: Routes.donate_path(conn, :new, slug))
    end
  end

  def show(conn, %{"slug" => slug}) do
    candidate = Accounts.get_candidate_by_slug(slug)
    render(conn, "show.html", candidate: candidate)
  end
end
