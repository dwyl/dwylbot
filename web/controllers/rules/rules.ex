defmodule Dwylbot.Rules do
  @moduledoc """
  Functions to check the wrokflow contribution rules
  """
  alias Dwylbot.Rules.List, as: RulesList

  def apply_and_check_errors(payload, event_type) do
    rules = RulesList.get_rules(event_type)
    rules
    |> Enum.filter(fn(m) -> apply(m, :apply?, [payload]) end)
    |> Enum.map(fn(m) -> apply(m, :check, [payload]) end)
    |> Enum.filter(fn(e) -> e != nil end)
  end

  @doc """
  load list of modules representing our rules
  and apply the rules to the payload to detect any errors
  """
  def check_errors(payload, event_type) do
    rules = RulesList.get_rules(event_type)
    rules
    |> Enum.map(fn(m) -> apply(m, :check, [payload]) end)
    |> Enum.filter(fn(e) -> e != nil end)
  end

  def compare(list_errors, event_errors) do
    Enum.filter event_errors, fn(e) -> has_error?(list_errors, e) end
  end

  defp has_error?(list_errors, err) do
    Enum.any?(list_errors, fn(e) -> e.error_type == err.error_type end)
  end
end
