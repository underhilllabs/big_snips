defmodule BigSnips.Post do
  use BigSnips.Web, :model

  schema "posts" do
    field :title, :string
    field :visibility, :integer
    has_many :snippets, BigSnips.Snippet
    belongs_to :user, BigSnips.User
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :visibility])
    |> validate_required([:title, :visibility])
  end
end