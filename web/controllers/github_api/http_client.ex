defmodule Dwylbot.GithubAPI.HTTPClient do
  @moduledoc """
  wrapper functions for the API Github App API
  """
  alias Poison.Parser, as: PP
  alias JOSE.JWK, as: JJ
  import Joken

  @media_type "application/vnd.github.machine-man-preview+json"
  @github_root "https://api.github.com"

  defp header(token) do
    ["Authorization": "token #{token}", "Accept": @media_type]
  end

  defp headerBearer(token) do
    ["Authorization": "Bearer #{token}", "Accept": @media_type]
  end

  def get_installations(token) do
    "#{@github_root}/user/installations"
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    |> Map.get("installations")
  end

  def get_repositories(token, id_installation) do
    "#{@github_root}/user/installations/#{id_installation}/repositories"
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    |> Map.get("repositories")
  end

  def get_installation_token(installation_id) do
    private_key = System.get_env("PRIVATE_APP_KEY")
    github_app_id = System.get_env("GITHUB_APP_ID")
    key = JJ.from_pem(private_key)
    my_token = %{
      iss: github_app_id,
      iat: DateTime.utc_now |> DateTime.to_unix,
      exp: (DateTime.utc_now |> DateTime.to_unix) + 100
    }
    |> token()
    |> sign(rs256(key))
    |> get_compact()

    "#{@github_root}/installations/#{installation_id}/access_tokens"
    |> HTTPoison.post!([], headerBearer(my_token))
    |> Map.fetch!(:body)
    |> PP.parse!
    |> Map.get("token")
  end

  def report_error(token, errors) do
    errors
    |> Enum.map(fn(error) -> error.actions end)
    |> Enum.concat()
    |> Enum.each(fn(action) -> post_action(action, token) end)
  end

  defp post_action(action, token) do
    case action do
      %{comment: comment, url: url} ->
        url
        |> HTTPoison.post!(Poison.encode!(%{body: comment}), header(token))
    end
  end

  def get_data(token, payload, "issue") do
    issue = payload["issue"]["url"]
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    %{"issue" => issue}
  end

  def get_data(token, payload, "pull_request") do
    pr = payload["pull_request"]["url"]
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    %{"pull_request" => pr}
  end

end
