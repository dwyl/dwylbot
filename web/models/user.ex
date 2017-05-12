defmodule Dwylbot.User do
  @moduledoc """
  Provide functions to represent users in Postgres with Ecto
  """
  use Dwylbot.Web, :model
  alias Dwylbot.Stock

  schema "users" do
    field :username, :string
    has_many :stocks, Stock
    has_many :repositories, through: [:stocks, :repository]

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:username])
    |> validate_length(:username, min: 1)
    |> unique_constraint(:username)
  end
end
