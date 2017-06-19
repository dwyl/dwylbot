defmodule Dwylbot.Rules.Issue.NoDescription do
  @moduledoc """
  Check for error when an issue is created without a description
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)

  def apply?(payload) do
    payload["action"] == "opened"
  end

  def check(payload, get_data?, token) do
    payload = (get_data? && @github_api.get_data(token, payload, "issue"))
              || payload
    description = String.trim payload["issue"]["body"]
    if String.length(description) == 0 do
      %{
        error_type: "issue_no_description",
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
    :stop_sign: @#{login}, the issue has no **description!**
    Please add more details to help us understand the context of the issue.
    Please read our [Contribution guide](https://github.com/dwyl/contributing#part-1-describe-your-question-the-idea-or-user-story-in-an-issue) on how to create issue
    Thanks! :heart:
    """
  end
end
