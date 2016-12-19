defmodule BigSnips.Snippet do
  use BigSnips.Web, :model

  schema "snippets" do
    field :body, :string
    field :filename, :string
    belongs_to :post, BigSnips.Post
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body, :filename])
    |> validate_required([:body, :filename])
  end
end
