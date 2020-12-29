defmodule NewYearsGames.Accounts do
  alias NewYearsGames.Repo
  alias NewYearsGames.Accounts.User

  @moduledoc """
  The accounts context.
  """

  alias NewYearsGames.Accounts.User

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end
end
