defmodule Chat.Repo do
  use Ecto.Repo, otp_app: :chat
  use Scrivener, page_size: 25
end
