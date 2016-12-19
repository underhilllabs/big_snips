defmodule Bookmarks.Repo.Migrations.AddPrivatePost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :is_private, :boolean
    end

  end
end
