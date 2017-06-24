defmodule Dwylbot.Rules.Issue.TimeEstimation do
  @moduledoc """
  Check errors for "in-progress and not time estimation" errors
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "issue_no_estimation"

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

    labels = payload["issue"]["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    estimation = labels
    |> Enum.map(fn(l) -> Regex.match?(~r/T\d{1,3}[mhd]/, l["name"]) end)
    |> Enum.reduce(false, fn(x, acc) -> x || acc end)
    if in_progress && !estimation do
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
    @#{login} the `in-progress` label has been added to this issue **without a time estimation**.
    Please add a time estimation to this issue before applying the `in-progress` label.
    """
  end
end
