defmodule Dwylbot.Rules.Inprogress do
  @moduledoc """
  Check errors for "in-progress and no assignees" errors
  """
  def apply?(payload) do
    payload["action"] == "labeled" && payload["label"]["name"] == "in-progress"
  end

  def check(payload) do
    assignees = payload["issue"]["assignees"]
    labels = payload["issue"]["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    if in_progress && Enum.empty?(assignees) do
      %{
        error_type: "inprogress_noassignees",
        error_message: payload["sender"] && error_message(payload["sender"]["login"])
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    @#{login} the `in-progress` label has been added to this issue **without an Assignee**.
    Please assign a user to this issue before applying the `in-progress label`.
    """
  end
end
