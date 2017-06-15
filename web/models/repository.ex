defmodule Dwylbot.Repository do
  @moduledoc """
  Provide functions to represent repositories in Postgres with Ecto
  """
  use Dwylbot.Web, :model
  alias Dwylbot.Stock

  schema "repositories" do
    field :name, :string
    has_many :stocks, Stock
    has_many :users, through: [:stocks, :user]

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:name])
    |> validate_length(:name, min: 1)
    |> unique_constraint(:name)
  end
end
