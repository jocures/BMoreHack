defmodule Gohireme.Repo do
  use Ecto.Repo,
    otp_app: :gohireme,
    adapter: Ecto.Adapters.Postgres
end
