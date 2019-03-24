defmodule GohiremeWeb.JobPostingController do
  use GohiremeWeb, :controller

  alias Gohireme.Transactions
  alias Gohireme.Transactions.JobPosting

  def index(conn, _params) do
    jobs =
      Transactions.list_job_postings()
      # |> Gohireme.Repo.preload(:company)

    render(conn, "index.html", jobs: jobs)
  end

  def show(conn, %{"id" => id}) do
    job_posting = Transactions.get_job_posting!(id)
    render(conn, "show.html", job_posting: job_posting)
  end
end
