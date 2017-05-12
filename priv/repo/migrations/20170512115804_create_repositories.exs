defmodule Dwylbot.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string

      timestamps
    end
    create unique_index(:repositories, [:name])
  end
end
