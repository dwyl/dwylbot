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
    # create post request with header to get the list of installation of a user.
    {:ok, res} = HTTPoison.get("https://api.github.com/user/installations", header(token), [])
    {:ok, data} = PP.parse(res.body)
    data["installations"]
  end
end
