defmodule BigSnips.Repo.Migrations.CreateSnippet do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :body, :text
      add :filename, :string

      timestamps()
    end

  end
end
