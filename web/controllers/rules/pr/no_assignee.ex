defmodule Dwylbot.Rules.PR.NoAssignee do
  @moduledoc """
  Check for error when an PR has awaiting-review but no assignees
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)

  def apply?(payload) do
    (payload["action"] == "labeled")
    || (payload["action"] == "unassigned")
    || (payload["action"] == "assigned")
  end

  def check(payload, _get_data?, token) do
    payload = @github_api.get_data(token, payload, "issue_from_pr")
    labels = payload["issue"]["labels"]
    assignees = payload["issue"]["assignees"]
    author = payload["issue"]["user"]["login"]
    incorrect_assignee = wrong_assignee(assignees, author)
    if Helpers.label_member?(labels, "awaiting-review") && incorrect_assignee do
      %{
        error_type: "pr_no_assignee",
        actions: [
          %{
            comment: error_message(payload["pull_request"]["sender"]["login"]),
            url: payload["issue"]["comments_url"]
          }
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
    :warning: @#{login}, the pull request is in "awaiting-review" but doesn't have a correct assignee.
    Please assign someone to review the pull request, thanks.
    """
  end

  defp wrong_assignee(assignees, login) do
    case length(assignees) do
      0 -> true
      1 ->
        name = assignees
        |> List.first()
        |> Map.get("login")

        (name == login)
      _ -> false
    end
  end

end
