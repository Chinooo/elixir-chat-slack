defmodule Chat.Accounts.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Accounts.Message


  schema "messages" do
    field :text, :string
    belongs_to :room, Chat.Accounts.Room
    belongs_to :user, Chat.Accounts.User

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:text, :user_id, :room_id])
    |> validate_required([:text, :user_id, :room_id])
  end
end
