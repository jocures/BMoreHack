defmodule GohiremeWeb.CompanyController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Accounts.Company

  def index(conn, _params) do
    companies = Accounts.list_companies()
    render(conn, "index.html", companies: companies)
  end

  def new(conn, _params) do
    changeset = Accounts.change_company(%Company{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"company" => company_params}) do
    company_params = case Map.get(company_params, "company_logo") do
      nil -> company_params
      logo -> 
        {:ok, %{public_id: public_id}} = Cloudex.upload(logo.path) 
        Map.put(company_params, "company_logo", public_id)
    end

    case Accounts.create_company(company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company created successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Accounts.get_company!(id)
    render(conn, "show.html", company: company)
  end

  def edit(conn, %{"id" => id}) do
    company = Accounts.get_company!(id)
    changeset = Accounts.change_company(company)
    render(conn, "edit.html", company: company, changeset: changeset)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Accounts.get_company!(id)

    case Accounts.update_company(company, company_params) do
      {:ok, company} ->
        conn
        |> put_flash(:info, "Company updated successfully.")
        |> redirect(to: Routes.company_path(conn, :show, company))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", company: company, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Accounts.get_company!(id)
    {:ok, _company} = Accounts.delete_company(company)

    conn
    |> put_flash(:info, "Company deleted successfully.")
    |> redirect(to: Routes.company_path(conn, :index))
  end
end
