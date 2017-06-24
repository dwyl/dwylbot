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

  def get_data(_token, _urls, rule_name) do
    mock = get_mock_file(rule_name)
    mock
    |> Enum.map(fn({type, file}) ->
      data = file
      |> File.read!()
      |> PP.parse!()
      {type, data}
    end)
    |> Enum.into(%{})
  end

  defp get_mock_file(rule_name) do
    config = %{
      "issue_inprogress_noassignees" =>
        [{"issue", "./test/fixtures/issue.json"}],
      "issue_no_description" =>
        [{"issue", "./test/fixtures/issue.json"}],
      "issue_unassigned_noassignees" =>
        [{"issue", "./test/fixtures/issue.json"}],
       "issue_no_estimation" =>
        [{"issue", "./test/fixtures/issue.json"}],
      "pr_no_assignee" =>
        [{"issue", "./test/fixtures/issue_from_pr.json"}],
      "pr_no_description" =>
        [{"pull_request", "./test/fixtures/pull_request.json"}],
      "pr_merge_conflicts" =>
        [
          {"issue", "./test/fixtures/issue.json"},
          {"pull_request", "./test/fixtures/pr.json"}
        ],
      "pr_awaiting_review" =>
        [
          {"issue", "./test/fixtures/issue_from_pr.json"},
          {"pull_request", "./test/fixtures/pr_reviewers-not_inprogress.json"}
        ],
      "pr_failing_test" =>
        [
          {"issue", "./test/fixtures/issue_from_pr_failing.json"},
          {"pull_request", "./test/fixtures/pr_failing.json"}
        ],
    }
    Map.get(config, rule_name)
  end

  def get_pull_requests(_token, _payload, rule_name) do
    [get_data(nil, nil, rule_name)]
  end

  def get_issue_from_status(_token, _payload, rule_name) do
    get_data(nil, nil, rule_name)
  end

  def report_error(_token, _error) do
    %{ok: 200}
  end
end
