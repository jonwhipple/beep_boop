defmodule BeepBoop.Repo do
  use Ecto.Repo,
    otp_app: :beep_boop,
    adapter: Ecto.Adapters.Postgres
end
