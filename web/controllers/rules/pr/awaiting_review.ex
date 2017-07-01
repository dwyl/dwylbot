defmodule Dwylbot.Rules.PR.AwaitingReview do
  @moduledoc """
  add awaiting-review if a reviewer has been added to the PR
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_awaiting_review"

  def apply?(payload) do
    (payload["action"] == "review_requested")
  end

  def check(payload, _get_data?, token) do
    urls = %{
      "issue" => payload["pull_request"]["issue_url"],
      "pull_request" => payload["pull_request"]["url"]
      }
    payload = @github_api.get_data(token, urls, @rule_name)

    reviewers = payload["pull_request"]["requested_reviewers"]
    |> Enum.map(&(&1["login"]))

    in_progress = payload["issue"]["labels"]
    |> Helpers.label_member?("in-progress")

    if (!Enum.empty?(reviewers) && !in_progress) do
      %{
        id: Helpers.get_id(payload),
        error_type: @rule_name,
        actions: [
          %{
            add_labels: ["awaiting-review"],
            url: "#{payload["issue"]["url"]}/labels"
          },
          %{
            add_assignees: reviewers,
            url: "#{payload["issue"]["url"]}/assignees"
          },
          %{
            comment: error_message(payload["issue"]["user"]["login"]),
            url: payload["issue"]["comments_url"]
          },
        ],
        wait: Helpers.wait(Mix.env, 30_000, 1000, 1),
        verify: true
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    @#{login}, a reviewer has been added to the pull request.
    The pull request looks ready for review (no "in-progress" label).
    So the reviewer has been added as an assignee and the "awaiting-reivew" label as been added to.
    """
  end

end
