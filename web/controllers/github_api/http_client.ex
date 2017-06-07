defmodule Dwylbot.GithubAPI.HTTPClient do
  @moduledoc """
  wrapper functions for the API Github App API
  """
  alias Poison.Parser, as: PP

  @media_type "application/vnd.github.machine-man-preview+json"

  defp header(token) do
    ["Authorization": "token #{token}", "Accept": @media_type]
  end

  def get_installations(token) do
    "https://api.github.com/user/installations"
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    |> Map.get("installations")
  end
end
