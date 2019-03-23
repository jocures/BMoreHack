defmodule GohiremeWeb.UserSessionController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.User

  alias Argon2
  
  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"email" => email, "encrypted_password" => password}}) do
    with %User{} = user <- Accounts.get_user_by_email(email),
         {:ok, %User{} = user} <- Argon2.check_pass(user, password, hide_user: true) do
      conn
      |> put_session(:current_user_id, user.id)
      |> redirect(to: Routes.page_path(conn, :index))
    else
      _ ->
        changeset = Accounts.change_user(%User{email: email})
        conn
        |> put_flash(:error, "Email address/password does not match.")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
