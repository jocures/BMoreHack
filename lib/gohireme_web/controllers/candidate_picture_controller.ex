defmodule GohiremeWeb.CandidatePictureController do
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

    candidate_params = case Map.get(candidate_params, "profile_image") do
      profile_image ->
        {:ok, %{public_id: public_id}} = Cloudex.upload(profile_image.path)
        Map.put(candidate_params, "profile_image", public_id)
      _ -> candidate_params
    end

    case Accounts.update_candidate(candidate, candidate_params) do
      {:ok, %Candidate{}} ->
        redirect(conn, to: Routes.pitch_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, candidate: candidate)
    end
  end

  def update(conn, params) do
    redirect(conn, to: Routes.pitch_path(conn, :new))
  end

end
