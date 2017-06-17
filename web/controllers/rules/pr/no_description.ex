defmodule Dwylbot.Rules.PR.NoDescription do
  @moduledoc """
  Check for error when an issue is created without a description
  """
  alias Dwylbot.Rules.Helpers

  def apply?(payload) do
    payload["action"] == "opened"
  end

  def check(payload) do
    description = String.trim payload["pull_request"]["body"]
    if String.length(description) == 0 do
      %{
        error_type: "pr_no_description",
        actions: [
          %{
            comment: payload["sender"] && error_message(payload["sender"]["login"]),
            url: payload["pull_request"]["comments_url"]
          }
        ],
        wait: Helpers.wait(30_000, 1000, 1)
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
