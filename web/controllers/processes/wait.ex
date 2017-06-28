defmodule Dwylbot.WaitProcess do
  @moduledoc """
  The delay function is used to create new checking rules processes
  """
  use GenServer
  alias Dwylbot.Rules

  def delay(error, payload, event_type, token) do
    Process.sleep(error.wait)
    error_token = Map.put(error, :token, token)

    if error.verify do
      check_errors = Rules.check_errors(payload, event_type, token)
      Rules.any_error?(check_errors, error)
      && GenServer.cast(Dwylbot.MergeErrors, {:error, error_token})
    else
      GenServer.cast(Dwylbot.MergeErrors, {:error, error_token})
    end
  end
end
