defmodule Dwylbot.GithubAPI.InMemory do
  @moduledoc """
  mock of github api functions for tests
  """
  def get_installations(_token) do
    [
      %{"account" => %{"login" => "dwyl"}},
      %{"account" => %{"login" => "FocusHub"}}
    ]
  end
end
