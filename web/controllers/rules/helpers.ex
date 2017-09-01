defmodule Dwylbot.Rules.Helpers do
  @moduledoc """
  Helper function
  wait: define the time for our rules to wait depeding on the environment
  """
  @doc """
    iex>wait(:prod, 1, 2, 3)
    1
    iex>wait(:dev, 1, 2, 3)
    2
    iex>wait(:test, 1, 2, 3)
    3
  """
  def wait(env, prod, dev, test) do
    case env do
      :prod -> prod
      :dev -> dev
      :test -> test
    end
  end

  @doc """
  iex>label_member?([%{"id" => 1, "name"=> "lb"}], "lb")
  true
  iex>label_member?([%{"id" => 1, "name" => "lb"}], "er")
  false
  """
  def label_member?(list_labels, label) do
    list_labels
    |> Enum.map(&(&1["name"]))
    |> Enum.member?(label)
  end

  @doc """
  iex>get_id(%{"repository" => %{"full_name" => "repo"}, "issue" => %{"number" => 42}})
  "repo/42"
  """
  def get_id(payload) when is_map(payload)do
    if Map.has_key?(payload, "repository") && Map.has_key?(payload, "issue") do
      "#{payload["repository"]["full_name"]}/#{payload["issue"]["number"]}"
    else
      nil
    end
  end

  @doc """
  iex>get_id([1,2,3])
  nil
  """
  def get_id(_payload) do
    nil
  end
end
