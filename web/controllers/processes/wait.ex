defmodule Dwylbot.WaitProcess do
  @moduledoc """
  The delay function is used to create new checking rules processes
  """
  alias Dwylbot.Rules
  @github_api Application.get_env(:dwylbot, :github_api)
  @duration Application.get_env(:dwylbot, :duration)

  def delay(payload, event_type) do
    errors = Rules.apply_and_check_errors(payload, event_type)
    unless Enum.empty?(errors) do
      Process.sleep(@duration)
      token = @github_api.get_installation_token(payload["installation"]["id"])
      data = @github_api.get_data(token, payload, event_type)
      check_errors = Rules.check_errors(data, event_type)
      errors_to_report = Rules.compare(check_errors, errors)
      @github_api.report_error(token, errors_to_report)
    end
  end
end
