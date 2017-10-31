defmodule Chat.RoomChannel do
  use Chat.Web, :channel

  def join("rooms:" <> room_id, _params, socket) do
    room = Repo.get!(Chat.Room, room_id)

    response = %{
      room: Phoenix.View.render_one(room, Chat.RoomView, "room.json"),
    }

    {:ok, response, assign(socket, :room, room)}
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
