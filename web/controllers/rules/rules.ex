defmodule Dwylbot.Rules do
  @moduledoc """
  Functions to check the wrokflow contribution rules
  """
  def check(payload, author) do
    assignees = payload["assignees"]
    labels = payload["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    if in_progress && Enum.empty?(assignees) do
      [%{error_type: "inprogress_noassignees", author: author}]
    else
      []
    end
  end

  def compare(errors, check) do
    Enum.filter check, fn(e) -> has_error?(errors, e) end
  end

  defp has_error?(list_errors, err) do
    Enum.any?(list_errors, fn(e) -> e.error_type == err.error_type end)
  end

  def generate_message_error(error) do
    case error.error_type do
      "inprogress_noassignees" ->
        """
        @#{error.author} the `in-progress` label has been added to this issue **without an Assignee**.
        Please assign a user to this issue before applying the `in-progress label`.
        """
    end
  end
end
