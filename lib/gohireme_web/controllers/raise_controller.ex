defmodule GohiremeWeb.RaiseController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts

  def show(conn, %{"id" => id}) do
    candidate = Accounts.get_candidate!(id)
    total_donations = Transactions.list_donations_for_candidate(id)

    render(conn, "show.html", candidate: candidate, total_donations: total_donations)
  end
end
