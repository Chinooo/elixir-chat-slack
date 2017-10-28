defmodule Chat.Accounts.UserRoom do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Accounts.UserRoom


  schema "user_rooms" do
    belongs_to :user, Chat.Accounts.User
    belongs_to :room, Chat.Accounts.Room

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :room_id])
    |> validate_required([:user_id, :room_id])
    |> unique_constraint(:user_id_room_id)
  end
end
