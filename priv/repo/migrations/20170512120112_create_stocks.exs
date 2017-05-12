defmodule Dwylbot.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks, primary_key: false) do
      add :user_id, references(:users, on_delete: :nilify_all)
      add :repository_id, references(:repositories, on_delete: :nilify_all)
    end
  end
end
