defmodule GohiremeWeb.CheckoutController do
  use GohiremeWeb, :controller

  alias Gohireme.Accounts

  def new(conn, %{"slug" => slug}) do
    candidate = Accounts.get_candidate_by_slug(slug)
    if is_nil(candidate), do: redirect(conn, Routes.page_path(@conn, :index))
    render(conn, "new.html", candidate: candidate)
  end
end
