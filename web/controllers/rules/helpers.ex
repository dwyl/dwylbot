defmodule Dwylbot.Rules.Helpers do
  @moduledoc """
  Helper function
  wait: define the time for our rules to wait depeding on the environment
  """

  def wait(prod, dev, test) do
    case Mix.env do
      :prod -> prod
      :dev -> dev
      :test -> test
    end
  end
end
