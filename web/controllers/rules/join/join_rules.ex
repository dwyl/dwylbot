defmodule Dwylbot.Rules.Join do
  @moduledoc """
  join rules together when necesssary:
  - in-progress label added: combine no_assignee with no_estimation
  - multiple reviewers added: combine add assignees rule
  """
  alias Dwylbot.Rules.Join.EstimationAssignee
  def join(rules) do
    rules
    |> EstimationAssignee.noassignee_noestimation()
  end

end
