defmodule Dwylbot.Rules.PR.AwaitingReview do
  @moduledoc """
  add awaiting-review if the
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)

  def apply?(payload) do
    (payload["action"] == "review_requested")
  end

  def check(payload, get_data?, token) do
    payload = (get_data? && @github_api.get_data(token, payload, "pull_request"))
              || payload
    reviewers = payload["pull_request"]["requested_reviewers"]
    |> Enum.map(&(&1["login"]))
    unless Enum.empty? payload["pull_request"]["requested_reviewers"] do
      %{
        error_type: "pr_awaiting_review",
        actions: [
          %{
            add_labels: ["awaiting-review"],
            url: "#{payload["pull_request"]["issue_url"]}/labels"
          },
          %{
            add_assignees: reviewers,
            url: "#{payload["pull_request"]["issue_url"]}/assignees"
          },
        ],
        wait: Helpers.wait(Mix.env, 30_000, 1000, 1),
        verify: true
      }
    else
      nil
    end
  end

end
