defmodule BigSnips.Repo.Migrations.AddPostIdSnippet do
  use Ecto.Migration

  def change do
    alter table(:snippets) do
      add :post_id, references(:posts) 
    end
  end
end
