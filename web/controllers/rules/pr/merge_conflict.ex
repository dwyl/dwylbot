defmodule Dwylbot.Rules.PR.MergeConflict do
  @moduledoc """
  Check for error when a PR has a merge conflict
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_merge_conflicts"

  @doc """
  iex>apply?(%{"action" => "closed", "pull_request" => %{"merged" => false}})
  false
  iex>apply?(%{"action" => "labeled", "label" => %{"name" => "awaiting-review"}})
  true
  iex>apply?(%{"action" => "unlabeled"})
  false
  """

  def apply?(%{"action" => "closed", "pull_request" => %{"merged" => merged}}), do: merged
  def apply?(%{"action" => "labeled", "label" => %{"name" => "awaiting-review"}}), do: true
  def apply?(%{"action" => _action}), do: false

  def check(payload, _get_data?, token) do
    payload = @github_api.get_pull_requests(token, payload, @rule_name)

    actions = payload
    |> Enum.filter(fn(pr) ->
      pr["pull_request"]["mergeable"] == false
      && !Helpers.label_member?(pr["issue"]["labels"], "merge-conflicts")
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
          add_labels: ["merge-conflicts"],
          url: "#{pr["issue"]["url"]}/labels"
        },
        %{
          remove_label: "awaiting-review",
          url: "#{pr["issue"]["url"]}/labels"
        }
    ]
    end)
    |> Enum.concat

    if length(actions) > 0 do
      %{
        error_type: @rule_name,
        actions: actions,
        wait: Helpers.wait(Mix.env, 40_000, 1000, 1),
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
