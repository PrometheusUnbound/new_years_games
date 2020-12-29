defmodule NewYearsGames.Repo do
  use Ecto.Repo,
    otp_app: :new_years_games,
    adapter: Ecto.Adapters.Postgres
end
