defmodule GohiremeWeb.JobPostingController do
  use GohiremeWeb, :controller

  alias Gohireme.Transations
  alias Gohireme.Transations.JobPosting

  def index(conn, _params) do
    jobs = Transations.list_job_postings()
    render(conn, "index.html", jobs: jobs)
  end

  def show(conn, %{"id" => id}) do
    job_posting = Transations.get_job_posting!(id)
    render(conn, "show.html", job_posting: job_posting)
  end
end
