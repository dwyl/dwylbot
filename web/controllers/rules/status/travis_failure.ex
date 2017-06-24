defmodule Dwylbot.Rules.Status.TravisFailure do
  @moduledoc """
  Check for test failing on PR with "awaiting-review" label
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_failing_test"

  def apply?(payload) do
    payload["state"] == "failure"
  end

  def check(payload, _get_data?, token) do
    payload = @github_api.get_issue_from_status(token, payload, @rule_name)
    labels = payload["issue"]["labels"]
    if Helpers.label_member?(labels, "awaiting-review") do
      %{
        error_type: @rule_name,
        actions: [
          %{
            remove_assignees: get_assignees_login(payload["issue"]["assignees"]),
            url: "#{payload["issue"]["url"]}/assignees"
          },
          %{
            comment: error_message(payload["pull_request"]["user"]["login"]),
            url: payload["issue"]["comments_url"]
          },
          %{
            add_assignees: [payload["pull_request"]["user"]["login"]],
            url: "#{payload["issue"]["url"]}/assignees"
          },
          %{
            remove_label: "awaiting-review",
            url: "#{payload["issue"]["url"]}/labels"
          }
        ],
        wait: Helpers.wait(Mix.env, 30_000, 1000, 1),
        verify: false
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    :warning: @#{login}, the pull request is in "awaiting-review" but some tests are failing.
    Please fix the tests and reassign when ready :+1:
    Thanks
    """
  end

  defp get_assignees_login(assignees) do
    assignees
    |> Enum.map(fn(a) -> a["login"] end)
  end

end
