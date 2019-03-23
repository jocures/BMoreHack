defmodule GohiremeWeb.UserSessionController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.User
  
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
  end
end
