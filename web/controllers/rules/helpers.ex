defmodule Dwylbot.Rules.Helpers do
  @moduledoc """
  Helper function
  wait: define the time for our rules to wait depeding on the environment
  """
  @doc """
    iex>waith(:prod, 1, 2, 3)
    1
    iex>waith(:dev, 1, 2, 3)
    2
    iex>waith(:test, 1, 2, 3)
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
