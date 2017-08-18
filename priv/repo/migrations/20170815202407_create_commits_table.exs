defmodule Dwylbot.Repo.Migrations.CreateCommits do
  use Ecto.Migration

  def change do
    create table(:commits) do
      add :sha, :string
      add :ci_status, :string

      timestamps
    end
    create unique_index(:commits, [:sha])
  end
end
