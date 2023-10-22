defmodule Virgule.Repo do
  use Ecto.Repo,
    otp_app: :virgule,
    adapter: Ecto.Adapters.Postgres
end
