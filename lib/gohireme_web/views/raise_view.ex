defmodule GohiremeWeb.RaiseView do
  use GohiremeWeb, :view

  def render_profile_image(nil), do: nil
  def render_profile_image(id) do
    src = Cloudex.Url.for(id)
    img_tag(src, alt: "Candidate Profile Image")
  end

  def render_video_embed(nil), do: nil
  def render_video_embed(url) do
    cond do
      Regex.match?(~r/youtube\.com/, url) ->
        case Regex.run(~r/v=([\w\d]+)/, url) do
          nil -> nil
          matches ->  
            video_id = List.last(matches)
            embed_url = "https://youtube.com/embed/#{video_id}"
            render(GohiremeWeb.CandidateProfileView, "youtube_embed.html", embed_url: embed_url) 
        end
      Regex.match?(~r/youtu\.be/, url) ->
        case Regex.run(~r/youtu\.be\/([\d\w]+)/, url) do
          nil -> nil
          matches ->
            video_id = List.last(matches)
            embed_url = "https://youtube.com/embed/#{video_id}"
            render(GohiremeWeb.CandidateProfileView, "youtube_embed.html", embed_url: embed_url) 
        end
      Regex.match?(~r/vimeo\.com/, url) -> 
        case Regex.run(~r/vimeo\.com\/([\d\w]+)/, url) do
          nil -> nil
          matches ->
            video_id = List.last(matches)
            embed_url = "https://player.vimeo.com/video/#{video_id}"
            render(GohiremeWeb.CandidateProfileView, "vimeo_embed.html", embed_url: embed_url)
        end
      true -> nil
    end
  end

  def render_raise_percentage(candidate, total_donations) do
    percentage = total_donations / (candidate.desired_raise * 10)
    render(GohiremeWeb.RaiseView, "raise_percentage.html", percentage: percentage)
  end

  def render_story(nil), do: content_tag(:p, "Looks like they haven't written anything yet...")
  def render_story(story) do
    paragraphs = String.split(story, "\n")
    Enum.map(paragraphs, fn p -> content_tag(:p, p) end)
  end
end
