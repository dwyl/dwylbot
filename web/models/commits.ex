defmodule Dwylbot.Commits do
  @moduledoc """
  Provide functions to represent users in Postgres with Ecto
  """
  use Dwylbot.Web, :model

  schema "commits" do
    field :sha, :string
    field :ci_status, :string

    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:sha])
    |> validate_length(:sha, min: 1)
    |> unique_constraint(:sha)
  end
end
