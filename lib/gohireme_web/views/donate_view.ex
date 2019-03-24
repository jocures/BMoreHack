defmodule GohiremeWeb.DonateView do
  use GohiremeWeb, :view

  def render_profile_image(nil), do: nil
  def render_profile_image(id) do
    src = Cloudex.Url.for(id)
    img_tag(src, alt: "Candidate Profile Image")
  end

  def render_raise_percentage(candidate, total_donations) do
    percentage = total_donations / (candidate.desired_raise * 10)
    render(GohiremeWeb.RaiseView, "raise_percentage.html", percentage: percentage)
  end

  def render_motivation_text(candidate, donation_amount) do
    percentage = donation_amount / candidate.desired_raise
    cond do
      percentage < 25 -> "They're just getting started!"
      percentage > 25 and percentage < 50 -> "They're almost halfway there!"
      percentage > 50 and percentage < 75 -> "They're more than halfway there!"
      percentage > 75 and percentage < 90 -> "Wow, look how much they've raised!"
      true -> "In the final stretch now!"
    end
  end
end
