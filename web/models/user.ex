defmodule BigSnips.User do
  use BigSnips.Web, :model

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(name password email))
    |> validate_required([:password, :email])
  end

  def registration_changeset(model, params) do 
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end
  
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
