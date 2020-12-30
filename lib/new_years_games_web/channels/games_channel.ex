defmodule NewYearsGamesWeb.GamesChannel do
  use NewYearsGamesWeb, :channel

  alias NewYearsGames.Game
  alias NewYearsGames.BackupAgent

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      playerid = payload["playerid"]
      game = BackupAgent.get(name) || Game.new()

      game = game
             |> Game.join_game(playerid)

      socket = socket
               |> assign(:game, game)
               |> assign(:name, name)
               |> assign(:playerid, playerid)

      BackupAgent.put(name, game)

      if Game.is_ready?(game) do
        send(self(), :game_ready)
      end

      {:ok, %{"game" => Game.client_view(game)}, socket}

    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def terminate(_reason, socket) do
    playerid = socket.assigns[:playerid]
    name = socket.assigns[:name]
    game = BackupAgent.get(name)
           |> Game.leave_game(playerid)
    BackupAgent.put(name, game)
    broadcast(socket, "update_game", %{})
    {:noreply, socket}
  end

  def handle_info(:game_ready, socket) do
    name = socket.assigns[:name]
    game = socket.assigns[:game]
           |> Game.start_turn
    BackupAgent.put(name, game)
    broadcast(socket, "game_ready", %{player_ids: game.player_ids})
    {:noreply, socket}
  end

  def handle_in("get_game", %{"playerid" => playerid}, socket) do
    name = socket.assigns[:name]
    game = BackupAgent.get(name)
    {:reply, {:ok, %{"game" => Game.client_view(game, playerid)}}}
  end

  # TODO: Add handling for getting next item
  # TODO: Add handling for inputting text (catch if the game is started)

  defp authorized?(_payload) do
    true
  end
end
