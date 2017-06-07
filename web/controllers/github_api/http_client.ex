defmodule Dwylbot.GithubAPI.HTTPClient do
  @moduledoc """
  wrapper functions for the API Github App API
  """
  alias Poison.Parser, as: PP

  @media_type "application/vnd.github.machine-man-preview+json"
  @github_root "https://api.github.com"

  defp header(token) do
    ["Authorization": "token #{token}", "Accept": @media_type]
  end

  def get_installations(token) do
    {:ok, res} = HTTPoison.get("#{@github_root}/user/installations", header(token), [])
    {:ok, data} = PP.parse(res.body)
    data["installations"]
  end

  def get_repositories(token, id_installation) do
    {:ok, res} = HTTPoison.get("#{@github_root}/user/installations/#{id_installation}/repositories", header(token), [])
    {:ok, data} = PP.parse(res.body)
    data["repositories"]
  end
end
