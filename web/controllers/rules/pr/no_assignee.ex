defmodule Dwylbot.Rules.PR.NoAssignee do
  @moduledoc """
  Check for error when an PR has awaiting-review but no assignees
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_no_assignee"

  def apply?(payload) do
    payload["action"] in ~w(labeled unassigned assigned)
  end

  def check(payload, _get_data?, token) do
    author_event = payload["sender"]["login"]
    url = payload["pull_request"]["issue_url"]
    payload = @github_api.get_data(token, %{"issue" => url}, @rule_name)
    labels = payload["issue"]["labels"]
    assignees = payload["issue"]["assignees"]
    author = payload["issue"]["user"]["login"]
    incorrect_assignee = wrong_assignee(assignees, author)
    if Helpers.label_member?(labels, "awaiting-review") && incorrect_assignee do
      %{
        error_type: @rule_name,
        actions: [
          %{
            comment: error_message(author_event),
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
