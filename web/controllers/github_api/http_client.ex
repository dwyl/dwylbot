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
    errors.actions
    |> Enum.each(fn(action) -> post_action(action, token) end)
  end

  defp post_action(action, token) do
    case action do
      %{comment: comment, url: url} ->
        feedback = """

        Any questions, complaints, feedback, contributions?
        [![Discuss](https://img.shields.io/badge/discuss-with%20us-brightgreen.svg?style=flat)](https://github.com/dwyl/dwylbot/issues "Discuss your ideas/suggestions with us!")
        If you prefer, you can also send us anonymous feedback: https://dwyl-feedback.herokuapp.com/feedback/new
        """
        message = comment <> feedback
        url
        |> HTTPoison.post!(Poison.encode!(%{body: message}), header(token))

      %{add_assignees: assignees, url: url} ->
        url
        |> HTTPoison.post!(
          Poison.encode!(%{assignees: assignees}), header(token)
        )

      %{remove_assignees: assignees, url: url} ->
        HTTPoison.request!(
          :delete, url, Poison.encode!(%{assignees: assignees}), header(token)
        )

      %{replace_labels: labels, url: url} ->
        url
        |> HTTPoison.put!(Poison.encode!(labels), header(token))

      %{add_labels: labels, url: url} ->
        url
        |> HTTPoison.post!(Poison.encode!(labels), header(token))
    end
  end

  def get_data(token, payload, "issue") do
    issue = payload["issue"]["url"]
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    %{"issue" => issue}
  end

  def get_data(token, payload, "issue_from_pr") do
    issue = payload["pull_request"]["issue_url"]
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    %{"issue" => issue, "pull_request" => payload}
  end

  def get_data(token, payload, "pull_request") do
    pr = payload["pull_request"]["url"]
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    %{"pull_request" => pr}
  end

  def get_data(token, payload, "list_pull_requests") do
    "#{@github_root}/repos/#{payload["repository"]["full_name"]}/pulls"
    |> HTTPoison.get!(header(token), [])
    |> Map.fetch!(:body)
    |> PP.parse!
    |> Enum.map(fn(pr) ->
      Map.merge(
        get_data(token, %{"pull_request" => %{"url" => pr["url"]}}, "pull_request"),
        get_data(token, %{"issue" => %{"url" => pr["issue_url"]}}, "issue")
      )
    end)
  end

end
