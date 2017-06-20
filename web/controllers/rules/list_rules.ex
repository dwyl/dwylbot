defmodule Dwylbot.Rules.List do
  @moduledoc """
  List of modules errors to check on Github event
  Each module must implement apply and check functions
  """
  alias Dwylbot.Rules.Issue
  alias Dwylbot.Rules.PR

  def get_rules(event_type) do
    case event_type do
      "issues" ->
        [
          Issue.Inprogress,
          Issue.Noassignees,
          Issue.TimeEstimation,
          Issue.NoDescription
        ]
      "pull_request" ->
        [
          PR.NoDescription,
          PR.MergeConflict,
          PR.NoAssignee,
          PR.AwaitingReview
        ]
      _ -> []
    end
  end
end
