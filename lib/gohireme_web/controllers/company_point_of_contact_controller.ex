defmodule GohiremeWeb.CompanyPointOfContactController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Company

  def new(conn, _params) do
    company =
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_company_for_user()
      |> Gohireme.Repo.preload(:user)

    changeset = Accounts.change_company(company)
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Accounts.get_company!(id)
    case Accounts.update_company(company, company_params) do
      {:ok, %Company{}} ->
        redirect(conn, to: Routes.company_job_posting_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, company: company)
    end
  end
end
