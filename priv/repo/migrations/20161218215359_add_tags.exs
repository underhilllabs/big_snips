defmodule BigSnips.Repo.Migrations.AddTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string 
    end
  end
end
