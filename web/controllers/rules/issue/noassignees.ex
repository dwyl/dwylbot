defmodule Dwylbot.Rules.Issue.Noassignees do
  @moduledoc """
  Check errors when an assignee is removed but the in-progress label
  is still on the issue (list of assignees should be empty too)
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "issue_unassigned_noassignees"

  def apply?(payload) do
    payload["action"] == "unassigned"
  end

  def check(payload, get_data?, token) do
    payload = if get_data? do
      url = payload["issue"]["url"]
      @github_api.get_data(token, %{"issue" => url}, @rule_name)
    else
      payload
    end
    assignees = payload["issue"]["assignees"]
    labels = payload["issue"]["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    if in_progress && Enum.empty?(assignees) do
      %{
        error_type: @rule_name,
        actions: [
          %{
            comment: payload["sender"] && error_message(payload["sender"]["login"]),
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
    :warning: @#{login} the assignee for this issue has been removed with the `in-progress` label still attached.
    Please remove the `in-progress` label if this issue is no longer being worked on or assign a user to this issue if it is still in progress.
    """
  end
end
