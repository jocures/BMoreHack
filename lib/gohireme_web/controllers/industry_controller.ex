defmodule GohiremeWeb.IndustryController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Candidate

  def new(conn, _params) do
    candidate = 
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_candidate_for_user()

    changeset = Accounts.change_candidate(candidate)
    render(conn, "new.html", changeset: changeset, candidate: candidate)
  end

  def update(conn, %{"id" => id, "candidate" => candidate_params}) do
    candidate = Accounts.get_candidate!(id)
    case Accounts.update_candidate(candidate, candidate_params) do
      {:ok, %Candidate{}} ->
        redirect(conn, to: Routes.salary_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, candidate: candidate)
    end
  end
end
