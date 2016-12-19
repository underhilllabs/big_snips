defmodule BigSnips.SnippetController do
  use BigSnips.Web, :controller

  alias BigSnips.Snippet

  def index(conn, _params) do
    snippets = Repo.all(Snippet)
    render(conn, "index.html", snippets: snippets)
  end

  def new(conn, _params) do
    changeset = Snippet.changeset(%Snippet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"snippet" => snippet_params}) do
    changeset = Snippet.changeset(%Snippet{}, snippet_params)

    case Repo.insert(changeset) do
      {:ok, _snippet} ->
        conn
        |> put_flash(:info, "Snippet created successfully.")
        |> redirect(to: snippet_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    snippet = Repo.get!(Snippet, id)
    render(conn, "show.html", snippet: snippet)
  end

  def edit(conn, %{"id" => id}) do
    snippet = Repo.get!(Snippet, id)
    changeset = Snippet.changeset(snippet)
    render(conn, "edit.html", snippet: snippet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "snippet" => snippet_params}) do
    snippet = Repo.get!(Snippet, id)
    changeset = Snippet.changeset(snippet, snippet_params)

    case Repo.update(changeset) do
      {:ok, snippet} ->
        conn
        |> put_flash(:info, "Snippet updated successfully.")
        |> redirect(to: snippet_path(conn, :show, snippet))
      {:error, changeset} ->
        render(conn, "edit.html", snippet: snippet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    snippet = Repo.get!(Snippet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(snippet)

    conn
    |> put_flash(:info, "Snippet deleted successfully.")
    |> redirect(to: snippet_path(conn, :index))
  end
end
