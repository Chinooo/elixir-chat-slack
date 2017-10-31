defmodule Chat.AccountsTest do
  use Chat.DataCase

  alias Chat.Accounts

  describe "users" do
    alias Chat.Accounts.User

    @valid_attrs %{email: "some email", password_hash: "some password_hash", username: "some username"}
    @update_attrs %{email: "some updated email", password_hash: "some updated password_hash", username: "some updated username"}
    @invalid_attrs %{email: nil, password_hash: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "rooms" do
    alias Chat.Accounts.Room

    @valid_attrs %{name: "some name", topic: "some topic"}
    @update_attrs %{name: "some updated name", topic: "some updated topic"}
    @invalid_attrs %{name: nil, topic: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Accounts.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Accounts.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Accounts.create_room(@valid_attrs)
      assert room.name == "some name"
      assert room.topic == "some topic"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, room} = Accounts.update_room(room, @update_attrs)
      assert %Room{} = room
      assert room.name == "some updated name"
      assert room.topic == "some updated topic"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_room(room, @invalid_attrs)
      assert room == Accounts.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Accounts.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Accounts.change_room(room)
    end
  end

  describe "user_rooms" do
    alias Chat.Accounts.UserRoom

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_room_fixture(attrs \\ %{}) do
      {:ok, user_room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_room()

      user_room
    end

    test "list_user_rooms/0 returns all user_rooms" do
      user_room = user_room_fixture()
      assert Accounts.list_user_rooms() == [user_room]
    end

    test "get_user_room!/1 returns the user_room with given id" do
      user_room = user_room_fixture()
      assert Accounts.get_user_room!(user_room.id) == user_room
    end

    test "create_user_room/1 with valid data creates a user_room" do
      assert {:ok, %UserRoom{} = user_room} = Accounts.create_user_room(@valid_attrs)
    end

    test "create_user_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_room(@invalid_attrs)
    end

    test "update_user_room/2 with valid data updates the user_room" do
      user_room = user_room_fixture()
      assert {:ok, user_room} = Accounts.update_user_room(user_room, @update_attrs)
      assert %UserRoom{} = user_room
    end

    test "update_user_room/2 with invalid data returns error changeset" do
      user_room = user_room_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_room(user_room, @invalid_attrs)
      assert user_room == Accounts.get_user_room!(user_room.id)
    end

    test "delete_user_room/1 deletes the user_room" do
      user_room = user_room_fixture()
      assert {:ok, %UserRoom{}} = Accounts.delete_user_room(user_room)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_room!(user_room.id) end
    end

    test "change_user_room/1 returns a user_room changeset" do
      user_room = user_room_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_room(user_room)
    end
  end

  describe "messages" do
    alias Chat.Accounts.Message

    @valid_attrs %{text: "some text"}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Accounts.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Accounts.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Accounts.create_message(@valid_attrs)
      assert message.text == "some text"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, message} = Accounts.update_message(message, @update_attrs)
      assert %Message{} = message
      assert message.text == "some updated text"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_message(message, @invalid_attrs)
      assert message == Accounts.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Accounts.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Accounts.change_message(message)
    end
  end
end
