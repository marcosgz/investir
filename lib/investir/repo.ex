defmodule Investir.Repo do
  use Ecto.Repo,
    otp_app: :investir,
    adapter: Ecto.Adapters.Postgres
end
