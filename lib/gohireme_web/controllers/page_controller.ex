defmodule GohiremeWeb.PageController do
  use GohiremeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def policies(conn, _params) do
    render(conn, "policies.html")
  end
end
