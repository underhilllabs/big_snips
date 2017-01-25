defmodule BigSnips.PostController do
  use BigSnips.Web, :controller
  plug :authenticate when action in [:edit, :new, :update, :create, :delete]

  alias BigSnips.Post

  def index(conn, params) do
    page = from(p in Post, 
                 order_by: [desc: p.updated_at])
            |> preload(:snippets)
            |> preload(:tags)
            |> Repo.paginate(params)
    render conn, "index.html", 
      page: page,
      posts: page.entries
  end

  def user(conn, params) do
    %{"id" => user_id} = params
    user = Repo.get!(BigSnips.User, user_id)
    page = from(p in Post, 
                 where: p.user_id == ^user_id,
                 order_by: [desc: p.updated_at])
            |> preload(:snippets)
            |> preload(:tags)
            |> Repo.paginate(params)
    render conn, "user.html", 
      page: page,
      posts: page.entries, 
      user: user
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{snippets: [ %BigSnips.Snippet{} ]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post = %Post{user_id: conn.assigns.current_user.id}
    changeset = Post.changeset(post, post_params)

    case Repo.insert(changeset) do
      {:ok, _post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload(:snippets) |> Repo.preload(:tags)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id) |> Repo.preload(:snippets) |> Repo.preload([:tags])
    %Post{tags: tags} = post
    tagstr = tags |> Enum.map(&(&1.name)) |> Enum.join(", ")
    changeset = Post.changeset(post, %{tags: tagstr})
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id) |> Repo.preload(:snippets) |> Repo.preload(:tags)
    changeset = Post.changeset(post, post_params)

    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: session_path(conn, :new))
      |> halt()
    end
  end
end
