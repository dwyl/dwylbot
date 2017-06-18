defmodule Dwylbot.Rules.Helpers do
  @moduledoc """
  Helper function
  wait: define the time for our rules to wait depeding on the environment
  """
  @doc """
    iex>Dwylbot.Rules.Helpers.wait(:prod, 1, 2, 3)
    1
    iex>Dwylbot.Rules.Helpers.wait(:dev, 1, 2, 3)
    2
    iex>Dwylbot.Rules.Helpers.wait(:test, 1, 2, 3)
    3
  """
  def wait(env, prod, dev, test) do
    case env do
      :prod -> prod
      :dev -> dev
      :test -> test
    end
  end
end
