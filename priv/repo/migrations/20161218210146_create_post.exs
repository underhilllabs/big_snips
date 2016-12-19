defmodule BigSnips.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :visibility, :integer

      timestamps()
    end

  end
end
