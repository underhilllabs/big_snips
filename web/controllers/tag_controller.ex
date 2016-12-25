defmodule BigSnips.TagController do
  use BigSnips.Web, :controller

  alias BigSnips.Tag
  alias BigSnips.PostTag
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    tags_count = from(t in Tag,
                      join: pt in PostTag, on: pt.tag_id == t.id,
                      select: [t.name, count(pt.tag_id)],
                      group_by: t.name,
                      limit: 50,
                      order_by: [desc: count(pt.tag_id), asc: pt.tag_id])
                 |> Repo.all
    render(conn, "index.html", tags_count: tags_count)
  end

  def name(conn, params) do
    %{"name" => name} = params
    page = from(p in BigSnips.Post,
                    join: pt in PostTag, on: p.id == pt.post_id,
                    join: t in Tag, on: t.id == pt.tag_id,
                    where: t.name == ^name,
                    order_by: [desc: p.updated_at],
                    preload: [:tags, :snippets])
                |> Repo.paginate(params) 
    render conn, "name.html", 
      name: name, 
      posts: page.entries,
      page: page
  end
end
