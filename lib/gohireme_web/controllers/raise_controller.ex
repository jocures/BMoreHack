defmodule GohiremeWeb.RaiseController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Transactions

  def show(conn, %{"slug" => slug}) do
    candidate = Accounts.get_candidate_by_slug(slug)
    if is_nil(candidate), do: redirect(conn, Routes.page_path(conn, :index))
    total_donations = 
      Transactions.list_donations_for_candidate(candidate.id)
      |> Enum.map(&(&1.amount))
      |> Enum.sum()

    render(conn, "show.html", candidate: candidate, total_donations: total_donations)
  end
end
