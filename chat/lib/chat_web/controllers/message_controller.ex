defmodule Chat.MessageController do
  use Chat.Web, :controller

  alias Chat.Accounts
  alias Chat.Accounts.Message

  action_fallback Chat.FallbackController

  def index(conn, _params) do
    messages = Accounts.list_messages()
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{} = message} <- Accounts.create_message(message_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", message_path(conn, :show, message))
      |> render("show.json", message: message)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Accounts.get_message!(id)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Accounts.get_message!(id)

    with {:ok, %Message{} = message} <- Accounts.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Accounts.get_message!(id)
    with {:ok, %Message{}} <- Accounts.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
