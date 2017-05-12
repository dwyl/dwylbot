defmodule Dwylbot.Stock do
  @moduledoc """
  Provide functions to represent the many-to-many relation user/repositories
  """
  use Dwylbot.Web, :model
  alias Dwylbot.{User, Repository}

  schema "stocks" do
    belongs_to :user, User
    belongs_to :repository, Repository
  end
end
