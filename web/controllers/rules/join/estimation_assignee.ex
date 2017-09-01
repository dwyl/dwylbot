defmodule Dwylbot.Rules.Join.EstimationAssignee do
  @moduledoc """
  This module merge the no assignees and no estimation errors together:
  - create and add a new error with a new comment action
  - delete the two original errors from the list of errors
  """

  def noassignee_noestimation(errors) do
    no_assignee = get_error_by_type(errors, "issue_inprogress_noassignees")
    no_estimation = get_error_by_type(errors, "issue_no_estimation")

    merge_errors? = no_assignee != nil
    && no_estimation != nil
    && no_assignee.id == no_estimation.id
    && no_assignee.id != nil

    if  merge_errors?  do
      actions = filter_actions(no_estimation.actions)
                ++ filter_actions(no_assignee.actions)

      comment_action = merge_comment_actions(no_assignee, no_estimation)

      new_error = %{
        token: no_assignee.token,
        actions: [comment_action| actions]
      }

      replace_errors(errors, no_assignee, no_estimation, new_error)
    else
      errors
    end
  end

  @doc """
    iex>get_error_by_type([%{error_type: "type_1"}], "no_match")
    nil
    iex>get_error_by_type([%{error_type: "type_1"}], "type_1")
    %{error_type: "type_1"}
  """
  def get_error_by_type(errors, error_type) do
    errors
    |> Enum.find(fn(err) ->
        err.error_type == error_type
       end)
  end

  @doc """
  iex>get_comment_action(%{actions: [%{assgin: "bob"}]})
  %{comment: "", url: ""}
  iex>get_comment_action(%{actions: [
  ...>%{assign: "bob"},
  ...>%{comment: "hello", url: "/comment"}]})
  %{comment: "hello", url: "/comment"}
  """
  def get_comment_action(error) do
    error.actions
    |> Enum.find(%{comment: "", url: ""}, fn(action) ->
      Map.has_key?(action, :comment)
    end)
  end

  @doc """
  iex>merge_comment_actions(
  ...>%{actions: [%{comment: "comment 1", url: "/comment"}]},
  ...>%{actions: [%{comment: "comment 2", url: "/comment"}]}
  ...>)
  %{comment: "comment 1\\n\\ncomment 2\\n", url: "/comment"}
  """
  def merge_comment_actions(err_1, err_2) do
    action_comment_1 = get_comment_action(err_1)
    action_comment_2 = get_comment_action(err_2)

    comment = """
    #{action_comment_1.comment}

    #{action_comment_2.comment}
    """
    %{
      comment: comment,
      url: action_comment_1.url
    }
  end

  @doc """
  iex>replace_errors(
  ...>[%{err: "err 1"}, %{err: "err 2"}, %{err: "err 3"}],
  ...>%{err: "err 1"},
  ...>%{err: "err 2"},
  ...>%{err: "new error"}
  ...>)
  [%{err: "new error"}, %{err: "err 3"}]
  """
  def replace_errors(errors, err_1, err_2, new_error) do
    delete_errors = errors
    |> List.delete(err_1)
    |> List.delete(err_2)

    [new_error | delete_errors]
  end

  @doc """
  iex>filter_actions([
  ...>%{comment: "comment acction", url: "/comment" },
  ...>%{assign: "bob", url: "/assign"}
  ...>])
  [%{assign: "bob", url: "/assign"}]
  """
  def filter_actions(actions) do
    actions
    |> Enum.filter(fn(action) ->
      !Map.has_key?(action, :comment)
    end)
  end

end
