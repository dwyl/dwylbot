defmodule Dwylbot.Rules.NoDescription do
  @moduledoc """
  Check for error when an issue is created without a description
  """
  def apply?(payload) do
    payload["action"] == "opened"
  end

  def check(payload) do
    description = String.trim payload["issue"]["body"]
    if String.length(description) == 0 do
      %{
        error_type: "no_description",
        error_message: payload["sender"] && error_message(payload["sender"]["login"])
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
