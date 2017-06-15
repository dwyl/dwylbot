defmodule Dwylbot.GithubAPI.InMemory do
  @moduledoc """
  mock of github api functions for tests
  """
  alias Poison.Parser, as: PP

  def get_installations(_token) do
    [
      %{"account" => %{"login" => "dwyl"}, "id" => "1"},
      %{"account" => %{"login" => "FocusHub"}, "id" => "2"}
    ]
  end

  def get_repositories(_token, _id_installation) do
    [
      %{"name" => "learn-elixir"}
    ]
  end

  def get_installation_token(_installation_id) do
    "token_installation_1234"
  end

  def get_issue(_token, _url) do
    "./test/fixtures/issue.json"
    |> File.read!()
    |> PP.parse!()
  end

  def report_error(_token, _errors) do
    %{ok: 200}
  end
end
