defmodule Chat.Accounts.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Accounts.Room


  schema "rooms" do
    field :name, :string
    field :topic, :string
    many_to_many :users, Chat.Accounts.User, join_through: "user_rooms"

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :topic])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
