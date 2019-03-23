defmodule Gohireme.Accounts.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gohireme.Accounts.User

  schema "candidates" do
    field :desired_industry, :string
    field :desired_job_title, :string
    field :first_name, :string
    field :last_name, :string
    field :location, :string
    field :salary_max, :integer
    field :salary_min, :integer
    field :desired_raise, :integer
    field :remote_ok, :boolean
    field :profile_image, :string

    field :pitch, :string
    field :story, :string
    field :linked_in_url, :string
    field :personal_website, :string

    field :pitch_video_url, :string
    field :hire_video_url, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:user_id, :first_name, :last_name, :salary_min, :salary_max, :location, :desired_job_title, :desired_industry, :desired_raise, :remote_ok, :profile_image, :pitch, :story, :linked_in_url, :personal_website, :pitch_video_url, :hire_video_url])
    |> validate_required([:first_name, :last_name])
    |> validate_number(:salary_min, greater_than: 0, less_than: :salary_max, message: "Can't be negative or more than max salary.")
    |> validate_number(:desired_raise, greater_than: 0, less_than: :salary_min, message: "Can't negative or more than annual salary.")
    |> validate_format(:linked_in_url, ~r/linkedin\.com/)
    |> validate_length(:pitch, max: 140)
    |> validate_format(:pitch_video_url, ~r/youtube\.com|vimeo\.com/, message: "Please put a link from YouTube or Vimeo.")
  end
end
