defmodule Dwylbot.Rules.PR.MergeConflict do
  @moduledoc """
  Check for error when a PR has a merge conflict
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)

  def apply?(payload) do
    payload["action"] == "closed" && payload["pull_request"]["merged"]
  end

  def check(payload, _get_data?, token) do
    payload = @github_api.get_data(token, payload, "list_pull_requests")

    actions = payload
    |> Enum.filter(fn(pr) ->
      !pr["pull_request"]["mergeable"]
    end)
    |> Enum.map(fn(pr) ->
      [
        %{
          remove_assignees: get_assignees_login(pr["issue"]["assignees"]),
          url: "#{pr["issue"]["url"]}/assignees"
        },
        %{
          comment: error_message(pr["pull_request"]["user"]["login"]),
          url: pr["pull_request"]["comments_url"]
        },
        %{
          add_assignees: [pr["pull_request"]["user"]["login"]],
          url: "#{pr["issue"]["url"]}/assignees"
        },
        %{
          replace_labels: ["merge-conflicts"],
          url: "#{pr["issue"]["url"]}/labels"
        }
    ]
    end)
    |> Enum.concat

    if length(actions) > 0 do
      %{
        error_type: "pr_merge_conflict",
        actions: actions,
        wait: Helpers.wait(Mix.env, 10_000, 1000, 1),
        verify: false
      }
    else
      nil
    end
  end

  defp get_assignees_login(assignees) do
    assignees
    |> Enum.map(fn(a) -> a["login"] end)
  end

  defp error_message(login) do
    """
    :warning: @#{login}, the pull request has a **merge conflict**.
    Please resolve the conflict and reassign when ready :+1:
    Thanks!
    """
  end
end
