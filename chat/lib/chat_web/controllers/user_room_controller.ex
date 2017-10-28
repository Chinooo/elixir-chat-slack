defmodule Chat.UserRoomController do
  use Chat.Web, :controller

  alias Chat.Accounts
  alias Chat.Accounts.UserRoom

  action_fallback Chat.FallbackController

  def index(conn, _params) do
    user_rooms = Accounts.list_user_rooms()
    render(conn, "index.json", user_rooms: user_rooms)
  end

  def create(conn, %{"user_room" => user_room_params}) do
    with {:ok, %UserRoom{} = user_room} <- Accounts.create_user_room(user_room_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_room_path(conn, :show, user_room))
      |> render("show.json", user_room: user_room)
    end
  end

  def show(conn, %{"id" => id}) do
    user_room = Accounts.get_user_room!(id)
    render(conn, "show.json", user_room: user_room)
  end

  def update(conn, %{"id" => id, "user_room" => user_room_params}) do
    user_room = Accounts.get_user_room!(id)

    with {:ok, %UserRoom{} = user_room} <- Accounts.update_user_room(user_room, user_room_params) do
      render(conn, "show.json", user_room: user_room)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_room = Accounts.get_user_room!(id)
    with {:ok, %UserRoom{}} <- Accounts.delete_user_room(user_room) do
      send_resp(conn, :no_content, "")
    end
  end
end
