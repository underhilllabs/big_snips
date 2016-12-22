defmodule BigSnips.Repo.Migrations.AddLangToSnippet do
  use Ecto.Migration

  def change do
    alter table(:snippets) do
      add :language, :string 
    end
  end
end
