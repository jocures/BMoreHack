defmodule GohiremeWeb.ProfileController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Candidate
  alias Gohireme.Accounts.Company

  plug :set_role_view

  def edit(conn, _params) do
    user_id = get_session(conn, :current_user_id)
    case Accounts.get_user_type(user_id) do
      %Candidate{} -> GohiremeWeb.CandidateProfileController.edit(conn, nil)
      _ -> redirect(conn, to: Routes.page_path(conn, :index))
    end
  end

  defp set_role_view(conn, _params) do
    user_id = get_session(conn, :current_user_id)
    case Accounts.get_user_type(user_id) do
      %Candidate{} -> 
        put_view(conn, GohiremeWeb.CandidateProfileView)
      _ -> conn
    end
  end
end
