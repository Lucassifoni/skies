defmodule Skies.Repo do
  use Ecto.Repo,
    otp_app: :skies,
    adapter: Ecto.Adapters.Postgres
end
