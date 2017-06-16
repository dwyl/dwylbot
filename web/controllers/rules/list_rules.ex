defmodule Dwylbot.Rules.List do
  @moduledoc """
  List of modules errors to check on Github event
  Each module must implement apply and check functions
  """
  def get_rules(event_type) do
    case event_type do
      "issues" ->
        [
          Dwylbot.Rules.Issue.Inprogress,
          Dwylbot.Rules.Issue.Noassignees,
          Dwylbot.Rules.Issue.TimeEstimation,
          Dwylbot.Rules.Issue.NoDescription
        ]
      "pull_request" ->
        [
          Dwylbot.Rules.PR.NoDescription
        ]
      _ -> []
    end
  end
end
