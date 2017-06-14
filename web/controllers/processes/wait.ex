defmodule Dwylbot.WaitProcess do
  @moduledoc """
  The delay function is used to create new checking rules processes
  """
  alias Dwylbot.Rules
  @github_api Application.get_env(:dwylbot, :github_api)
  @duration Application.get_env(:dwylbot, :duration)

  def delay(payload) do
    errors = Rules.apply_and_check_errors(payload)

    unless Enum.empty?(errors) do
      Process.sleep(@duration)
      token = @github_api.get_installation_token(payload["installation"]["id"])
      issue_url = payload["issue"]["url"]
      comments_url = payload["issue"]["comments_url"]
      issue = @github_api.get_issue(token, issue_url)
      check_errors = Rules.check_errors(%{"issue" => issue})
      errors_to_report = Rules.compare(check_errors, errors)
      @github_api.report_error(token, errors_to_report, comments_url)
    end
  end
end
