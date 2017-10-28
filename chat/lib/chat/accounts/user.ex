defmodule Chat.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chat.Accounts.User


  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 3)
    |> put_password_hash()
  end

  @doc false
  def registration_changeset(%User{} = user, params) do
    user
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 3)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash,
                  Comeonin.Bcrypt.hashpwsalt(pass))
                  _ ->
                    changeset
                  end
                end

end
