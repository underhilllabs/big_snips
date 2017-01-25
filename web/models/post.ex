defmodule BigSnips.Post do
  use BigSnips.Web, :model

  schema "posts" do
    field :title, :string
    field :visibility, :integer
    field :is_private, :boolean
    has_many :snippets, BigSnips.Snippet
    many_to_many :tags, BigSnips.Tag, join_through: BigSnips.PostTag, on_replace: :delete
    belongs_to :user, BigSnips.User
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :visibility])
    |> validate_required([:title])
    |> cast_assoc(:snippets)
    |> Ecto.Changeset.put_assoc(:tags, parse_tags(params))
  end

  def parse_tags(params) do
    (params["tags"] || params["taglist"] || "")
    |> String.split(",") 
    |> Enum.map(&(String.trim(&1, " ")))
    |> Enum.reject(& &1 == "")
    |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    BigSnips.Repo.get_by(BigSnips.Tag, name: name) || BigSnips.Repo.insert!(%BigSnips.Tag{name:  name})
  end

  def tag_link(tagstr) do
    tagstr
    |> Enum.map(&(&1.name))
    |> Enum.map(&("<span class='tag'><a href='/tags/name/#{&1}'>#{&1}</a></span>"))
    |> Enum.join(" ")
  end
end
