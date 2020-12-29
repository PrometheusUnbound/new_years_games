defmodule NewYearsGamesWeb.UserView do
  use NewYearsGamesWeb, :view

  alias NewYearsGames.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
