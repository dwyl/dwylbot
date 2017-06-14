defmodule Dwylbot.Rules.TimeEstimation do
  @moduledoc """
  Check errors for "in-progress and not time estimation" errors
  """
  def apply?(payload) do
    payload["action"] == "labeled" && payload["label"]["name"] == "in-progress"
  end

  def check(payload) do
    time = [
      "T1d",
      "T1h",
      "T2h",
      "T4h",
      "T25mn"
    ]
    labels = payload["issue"]["labels"]
    in_progress = Enum.any?(labels, fn(l) -> l["name"] == "in-progress" end)
    estimation = time
    |> Enum.map(fn(t) -> Enum.any?(labels, fn(l) -> l["name"] == t end) end)
    |> Enum.reduce(fn(x, acc) -> x || acc end)
    if in_progress && !estimation do
      %{
        error_type: "noestimation",
        error_message: payload["sender"] && error_message(payload["sender"]["login"])
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    @#{login} the `in-progress` label has been added to this issue **without a time estimation**.
    Please add a time estimation to this issue before applying the `in-progress label`.
    """
  end
end
