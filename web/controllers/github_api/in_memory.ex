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

  def get_data(_token, _payload, "issue") do
    issue = "./test/fixtures/issue.json"
    |> File.read!()
    |> PP.parse!()
    %{"issue" => issue}
  end

  def get_data(_token, _payload, "issue_from_pr") do
    issue = "./test/fixtures/issue_from_pr.json"
    |> File.read!()
    |> PP.parse!()

    pr = "./test/fixtures/pr_no_assignee.json"
    |> File.read!()
    |> PP.parse!()
    %{"issue" => issue, "pull_request" => pr}
  end

  def get_data(_token, _payload, "pull_request") do
    pr = "./test/fixtures/pull_request.json"
    |> File.read!()
    |> PP.parse!()
    %{"pull_request" => pr}
  end

  def get_data(_token, _payload, "list_pull_requests") do
    pr = "./test/fixtures/pr.json"
    |> File.read!()
    |> PP.parse!()

    issue = "./test/fixtures/issue_pr.json"
    |> File.read!()
    |> PP.parse!()

    [%{"pull_request" => pr, "issue" => issue}]
  end

  def report_error(_token, _error) do
    %{ok: 200}
  end
end
