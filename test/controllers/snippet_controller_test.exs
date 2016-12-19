defmodule BigSnips.SnippetControllerTest do
  use BigSnips.ConnCase

  alias BigSnips.Snippet
  @valid_attrs %{body: "some content", filename: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, snippet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing snippets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, snippet_path(conn, :new)
    assert html_response(conn, 200) =~ "New snippet"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, snippet_path(conn, :create), snippet: @valid_attrs
    assert redirected_to(conn) == snippet_path(conn, :index)
    assert Repo.get_by(Snippet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, snippet_path(conn, :create), snippet: @invalid_attrs
    assert html_response(conn, 200) =~ "New snippet"
  end

  test "shows chosen resource", %{conn: conn} do
    snippet = Repo.insert! %Snippet{}
    conn = get conn, snippet_path(conn, :show, snippet)
    assert html_response(conn, 200) =~ "Show snippet"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, snippet_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    snippet = Repo.insert! %Snippet{}
    conn = get conn, snippet_path(conn, :edit, snippet)
    assert html_response(conn, 200) =~ "Edit snippet"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    snippet = Repo.insert! %Snippet{}
    conn = put conn, snippet_path(conn, :update, snippet), snippet: @valid_attrs
    assert redirected_to(conn) == snippet_path(conn, :show, snippet)
    assert Repo.get_by(Snippet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    snippet = Repo.insert! %Snippet{}
    conn = put conn, snippet_path(conn, :update, snippet), snippet: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit snippet"
  end

  test "deletes chosen resource", %{conn: conn} do
    snippet = Repo.insert! %Snippet{}
    conn = delete conn, snippet_path(conn, :delete, snippet)
    assert redirected_to(conn) == snippet_path(conn, :index)
    refute Repo.get(Snippet, snippet.id)
  end
end
