defmodule GohiremeWeb.CandidateProfileController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Candidate

  def edit(conn, _params) do
    candidate = 
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_candidate_for_user()
      |> Gohireme.Repo.preload(:user)

    changeset = Accounts.change_candidate(candidate)

    render(conn, "edit.html", candidate: candidate, changeset: changeset)
  end

  def update(conn, %{"candidate" => candidate_params}) do
    candidate =
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_candidate_for_user()

    case Accounts.update_candidate(candidate, candidate_params) do
      {:ok, %Candidate{}} -> redirect(conn, to: Routes.profile_path(conn, :edit))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, candidate: candidate)
    end
  end
end
