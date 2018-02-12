defmodule DwylbotWeb.Rules.List do
  @moduledoc """
  List of modules errors to check on Github event
  Each module must implement apply and check functions
  """
  alias DwylbotWeb.Rules.Issue
  alias DwylbotWeb.Rules.PR
  alias DwylbotWeb.Rules.Status

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
          PR.NoAssigneeOrReviewer,
          PR.AwaitingReview,
          PR.ReviewerButNoAssignee
        ]
      "status" ->
        [
          Status.TravisFailure
        ]
      _ -> []
    end
  end
end
