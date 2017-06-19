defmodule Dwylbot.Rules.Issue.Noassignees do
  @moduledoc """
  Check errors when an assignee is removed but the in-progress label
  is still on the issue (list of assignees should be empty too)
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)

  def apply?(payload) do
    payload["action"] == "unassigned"
  end

  def check(payload, get_data?, token) do
    payload = (get_data? && @github_api.get_data(token, payload, "issue"))
              || payload
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
    :warning: @#{login} issue has no **assignee** but is still `in-progress`. Who is working on it?
    Please assign a user to this issue or remove the `in-progress` label. Thanks! :heart:
    """
  end
end
