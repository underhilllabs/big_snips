defmodule BigSnips.PostTag do
  use BigSnips.Web, :model

  schema "posts_tags" do
    belongs_to :post, BigSnips.Post
    belongs_to :tag, BigSnips.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [])
    |> validate_required([])
  end
end
