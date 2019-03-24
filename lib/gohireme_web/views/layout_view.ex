defmodule GohiremeWeb.LayoutView do
  use GohiremeWeb, :view

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Candidate
  alias Gohireme.Accounts.Company 

  def render_navigation(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    case Accounts.get_user_type(user_id) do
      %Candidate{} = candidate -> 
        render GohiremeWeb.SharedView, "candidate_header.html", conn: conn, candidate: candidate
      %Company{} ->
        render GohiremeWeb.SharedView, "company_header.html", conn: conn
      _ ->
        render GohiremeWeb.SharedView, "unauthenticated_header.html", conn: conn
    end
  end
end
