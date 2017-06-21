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
    :warning: @#{login}, this issue has no description. Please add a description to help others understand the context of this issue.

    --

    You can read more about how to create an issue in a dwyl repository [here](https://github.com/dwyl/contributing#part-1-describe-your-question-the-idea-or-user-story-in-an-issue).
    Full guidelines for contributing to a dwyl repository can be found [here](https://github.com/dwyl/contributing/blob/master/README.md).
    """
  end
end
