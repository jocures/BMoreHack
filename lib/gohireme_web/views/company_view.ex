defmodule GohiremeWeb.CompanyView do
  use GohiremeWeb, :view

  def render_logo(nil), do: nil
  def render_logo(id) do
    src = Cloudex.Url.for(id, %{width: 100})
    img_tag(src)
  end
end
