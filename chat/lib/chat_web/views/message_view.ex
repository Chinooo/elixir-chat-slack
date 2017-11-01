defmodule ChatWeb.MessageView do
  use Chat.Web, :view
  alias Chat.Web.MessageView

  # def render("index.json", %{messages: messages}) do
  #   %{data: render_many(messages, MessageView, "message.json")}
  # end

  def render("index.json", %{messages: messages, pagination: pagination}) do
  %{
    data: render_many(messages, Chat.MessageView, "message.json"),
    pagination: pagination
  }
end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{
      id: message.id,
      inserted_at: message.inserted_at,
      text: message.text,
      user: %{
        email: message.user.email,
        username: message.user.username
        }
      }
  end
end
