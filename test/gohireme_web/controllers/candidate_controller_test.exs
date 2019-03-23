defmodule GohiremeWeb.CandidateControllerTest do
  use GohiremeWeb.ConnCase

  alias Gohireme.Accounts

  @create_attrs %{desired_industry: "some desired_industry", desired_job_title: "some desired_job_title", first_name: "some first_name", last_name: "some last_name", location: "some location", salary_max: 42, salary_min: 42}
  @update_attrs %{desired_industry: "some updated desired_industry", desired_job_title: "some updated desired_job_title", first_name: "some updated first_name", last_name: "some updated last_name", location: "some updated location", salary_max: 43, salary_min: 43}
  @invalid_attrs %{desired_industry: nil, desired_job_title: nil, first_name: nil, last_name: nil, location: nil, salary_max: nil, salary_min: nil}

  def fixture(:candidate) do
    {:ok, candidate} = Accounts.create_candidate(@create_attrs)
    candidate
  end

  describe "index" do
    test "lists all candidates", %{conn: conn} do
      conn = get(conn, Routes.candidate_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Candidates"
    end
  end

  describe "new candidate" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.candidate_path(conn, :new))
      assert html_response(conn, 200) =~ "New Candidate"
    end
  end

  describe "create candidate" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.candidate_path(conn, :create), candidate: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.candidate_path(conn, :show, id)

      conn = get(conn, Routes.candidate_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Candidate"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.candidate_path(conn, :create), candidate: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Candidate"
    end
  end

  describe "edit candidate" do
    setup [:create_candidate]

    test "renders form for editing chosen candidate", %{conn: conn, candidate: candidate} do
      conn = get(conn, Routes.candidate_path(conn, :edit, candidate))
      assert html_response(conn, 200) =~ "Edit Candidate"
    end
  end

  describe "update candidate" do
    setup [:create_candidate]

    test "redirects when data is valid", %{conn: conn, candidate: candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @update_attrs)
      assert redirected_to(conn) == Routes.candidate_path(conn, :show, candidate)

      conn = get(conn, Routes.candidate_path(conn, :show, candidate))
      assert html_response(conn, 200) =~ "some updated desired_industry"
    end

    test "renders errors when data is invalid", %{conn: conn, candidate: candidate} do
      conn = put(conn, Routes.candidate_path(conn, :update, candidate), candidate: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Candidate"
    end
  end

  describe "delete candidate" do
    setup [:create_candidate]

    test "deletes chosen candidate", %{conn: conn, candidate: candidate} do
      conn = delete(conn, Routes.candidate_path(conn, :delete, candidate))
      assert redirected_to(conn) == Routes.candidate_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.candidate_path(conn, :show, candidate))
      end
    end
  end

  defp create_candidate(_) do
    candidate = fixture(:candidate)
    {:ok, candidate: candidate}
  end
end
