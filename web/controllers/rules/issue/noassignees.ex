defmodule Dwylbot.Rules.Issue.Noassignees do
  @moduledoc """
  Check errors when an assignee is removed but the in-progress label
  is still on the issue (list of assignees should be empty too)
  """
  def apply?(payload) do
    payload["action"] == "unassigned"
  end

  def check(payload) do
    assignees = payload["issue"]["assignees"]
    labels = payload["issue"]["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    if in_progress && Enum.empty?(assignees) do
      %{
        error_type: "issue_inprogress_noassignees",
        actions: [
          %{
            comment: payload["sender"] && error_message(payload["sender"]["login"]),
            url: payload["issue"]["comments_url"]
          }
        ]
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    :warning: @#{login} issue has no **assignee** but is still `in-progress`. Who is working on it?
    Please assign a user to this issue or remove the `in-progress` label. Thanks! :heart:
    """
  end
end
