defmodule Dwylbot.Rules.PR.NoDescription do
  @moduledoc """
  Check for error when an issue is created without a description
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_no_description"

  def apply?(payload) do
    payload["action"] == "opened"
  end

  def check(payload, get_data?, token) do
    payload = if get_data? do
      url = payload["pull_request"]["url"]
      @github_api.get_data(token, %{"pull_request" => url}, @rule_name)
    else
      payload
    end
    description = String.trim payload["pull_request"]["body"]
    if String.length(description) == 0 do
      %{
        error_type: @rule_name,
        actions: [
          %{
            comment: payload["sender"] && error_message(payload["sender"]["login"]),
            url: payload["pull_request"]["comments_url"]
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
    :stop_sign: @#{login}, the pull request has no **description!**
    Please add more details to help us understand the context of the pull request.
    Please read our [Contribution guide](https://github.com/dwyl/contributing#notes-on-creating-good-pull-requests) on how to create a good pull request.
    Thanks! :heart:
    """
  end
end
