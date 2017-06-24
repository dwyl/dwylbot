defmodule Dwylbot.Rules.Issue.Inprogress do
  @moduledoc """
  Check errors for "in-progress and no assignees" errors
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "issue_inprogress_noassignees"

  def apply?(payload) do
    payload["action"] == "labeled" && payload["label"]["name"] == "in-progress"
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
          },
          %{
            add_assignees: [payload["sender"]["login"]],
            url: "#{payload["issue"]["url"]}/assignees"
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
    @#{login} the `in-progress` label has been added to this issue **without an Assignee**.
    dwylbot has automatically assigned you.
    """
  end
end
