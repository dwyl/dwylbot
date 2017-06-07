defmodule Dwylbot.GithubAPI.InMemory do
  @moduledoc """
  mock of github api functions for tests
  """
  def get_installations(_token) do
    [
      %{"account" => %{"login" => "dwyl"}, "id" => "1"},
      %{"account" => %{"login" => "FocusHub"}, "id" => "2"}
    ]
  end

  def get_repositories(_token, id_installation) do
    [
      %{"name" => "learn-elixir"}
    ]
  end
end
