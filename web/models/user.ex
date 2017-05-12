defmodule Dwylbot.User do
  @moduledoc """
  Provide functions to represent users in Postgres with Ecto
  """
  use Dwylbot.Web, :model

  schema "users" do
    field :username, :string

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:username])
    |> validate_length(:username, min: 1)
    |> unique_constraint(:username)
  end
end
