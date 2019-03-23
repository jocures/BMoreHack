defmodule GohiremeWeb.CompanyJobPostingController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts
  alias Gohireme.Transactions
  alias Gohireme.Accounts.Company
  alias Gohireme.Transactions.JobPosting

  def new(conn, _params) do
    company =
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_company_for_user()

    changeset = Transactions.change_job_posting(%JobPosting{})
    render(conn, "new.html", changeset: changeset, company: company)
  end

  def create(conn, %{"job_posting" => job_posting_params}) do
    company =
      conn
      |> get_session(:current_user_id)
      |> Accounts.get_company_for_user()

    job_posting_params =
      job_posting_params
      |> Map.merge(%{"company_id" => company.id})

    case Transactions.create_job_posting(job_posting_params) do
      {:ok, job_posting} ->
        conn
        |> put_flash(:info, "Job posting created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "job_posting" => job_posting_params}) do
    job_posting = Accounts.get_job_posting!(id)
    case Accounts.update_job_posting(job_posting, job_posting_params) do
      {:ok, %JobPosting{}} ->
        redirect(conn, to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, job_posting: job_posting)
    end
  end
end
