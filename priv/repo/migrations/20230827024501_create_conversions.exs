defmodule BeepBoop.Repo.Migrations.CreateConversions do
  use Ecto.Migration

  def change do
    create table(:conversions) do
      add :input, :text
      add :binary, :text
      add :markdown, :text

      timestamps()
    end
  end
end
