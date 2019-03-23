defmodule GohiremeWeb.PitchView do
  use GohiremeWeb, :view

  def pitch_length(nil), do: 0
  def pitch_length(pitch), do: String.length(pitch)
end
