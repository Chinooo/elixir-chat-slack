defmodule ChatWeb.UserRoomControllerTest do
  use ChatWeb.ConnCase

  alias Chat.Accounts
  alias Chat.Accounts.UserRoom

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:user_room) do
    {:ok, user_room} = Accounts.create_user_room(@create_attrs)
    user_room
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all user_rooms", %{conn: conn} do
      conn = get conn, user_room_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user_room" do
    test "renders user_room when data is valid", %{conn: conn} do
      conn = post conn, user_room_path(conn, :create), user_room: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, user_room_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, user_room_path(conn, :create), user_room: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user_room" do
    setup [:create_user_room]

    test "renders user_room when data is valid", %{conn: conn, user_room: %UserRoom{id: id} = user_room} do
      conn = put conn, user_room_path(conn, :update, user_room), user_room: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, user_room_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, user_room: user_room} do
      conn = put conn, user_room_path(conn, :update, user_room), user_room: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user_room" do
    setup [:create_user_room]

    test "deletes chosen user_room", %{conn: conn, user_room: user_room} do
      conn = delete conn, user_room_path(conn, :delete, user_room)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, user_room_path(conn, :show, user_room)
      end
    end
  end

  defp create_user_room(_) do
    user_room = fixture(:user_room)
    {:ok, user_room: user_room}
  end
end
