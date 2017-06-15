defmodule Dwylbot.Rules.List do
  @moduledoc """
  List of modules errors to check on Github event
  Each module must implement apply and check functions
  """
  def get_rules do
    [
      Dwylbot.Rules.Inprogress,
      Dwylbot.Rules.Noassignees,
      Dwylbot.Rules.TimeEstimation
    ]
  end
end
