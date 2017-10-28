defmodule Chat.RoomController do
  use Chat.Web, :controller

  alias Chat.Accounts
  alias Chat.Accounts.Room

  action_fallback Chat.FallbackController

  def index(conn, _params) do
    rooms = Accounts.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, %{"room" => room_params}) do
    with {:ok, %Room{} = room} <- Accounts.create_room(room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Accounts.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Accounts.get_room!(id)

    with {:ok, %Room{} = room} <- Accounts.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Accounts.get_room!(id)
    with {:ok, %Room{}} <- Accounts.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
