defmodule GohiremeWeb.CandidateController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Candidate

  def index(conn, _params) do
    candidates = Accounts.list_candidates()
    render(conn, "index.html", candidates: candidates)
  end

  def new(conn, _params) do
    candidate = 
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_candidate_for_user()


    if candidate do
      changeset = Accounts.change_candidate(candidate)
      render(conn, "edit.html", changeset: changeset, candidate: candidate)
    else
      changeset = Accounts.change_candidate(%Candidate{})
      render(conn, "new.html", changeset: changeset)
    end

  end

  def create(conn, %{"candidate" => candidate_params}) do
    user_id = get_session(conn, :current_user_id)
    case Accounts.create_candidate(Map.put(candidate_params, "user_id", user_id)) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate created successfully.")
        |> redirect(to: Routes.industry_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    candidate = Accounts.get_candidate!(id)
    render(conn, "show.html", candidate: candidate)
  end

  def edit(conn, %{"id" => id}) do
    candidate = Accounts.get_candidate!(id)
    changeset = Accounts.change_candidate(candidate)
    render(conn, "edit.html", candidate: candidate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "candidate" => candidate_params}) do
    candidate = Accounts.get_candidate!(id)

    case Accounts.update_candidate(candidate, candidate_params) do
      {:ok, candidate} ->
        conn
        |> put_flash(:info, "Candidate updated successfully.")
        |> redirect(to: Routes.industry_path(conn, :new))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", candidate: candidate, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    candidate = Accounts.get_candidate!(id)
    {:ok, _candidate} = Accounts.delete_candidate(candidate)

    conn
    |> put_flash(:info, "Candidate deleted successfully.")
    |> redirect(to: Routes.candidate_path(conn, :index))
  end
end
