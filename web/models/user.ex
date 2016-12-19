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
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password_hash, :email])
    |> validate_required([:name, :password_hash, :email])
  end
end
