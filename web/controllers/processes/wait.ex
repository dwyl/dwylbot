defmodule Dwylbot.WaitProcess do
  @moduledoc """
  The delay function is used to create new checking rules processes
  """
  alias Dwylbot.Rules
  @github_api Application.get_env(:dwylbot, :github_api)

  def delay(error, payload, event_type, token) do
    Process.sleep(error.wait)
    if error.verify do
      check_errors = Rules.check_errors(payload, event_type, token)
      Rules.any_error?(check_errors, error)
      && @github_api.report_error(token, error)
    else
      @github_api.report_error(token, error)
    end
  end
end
