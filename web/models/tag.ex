defmodule BigSnips.Tag do
  use BigSnips.Web, :model

  schema "tags" do
    field :name, :string
    many_to_many :posts, BigSnips.Post, join_through: BigSnips.PostTag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end
