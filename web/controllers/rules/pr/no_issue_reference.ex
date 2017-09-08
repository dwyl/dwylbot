defmodule Dwylbot.Rules.PR.NoIssueReference do
  @moduledoc """
  reassign user if no issue has been referenced
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_no_issue_reference"

  def apply?(payload) do
    payload["action"] in ~w(review_requested assigned)
  end

  def check(payload, _get_data?, token) do

    authorIsAssigned = payload["pull_request"]["assignees"]
      |> get_assignees_login
      |> Enum.member?(payload["pull_request"]["base"]["user"]["login"])


    if (!pr_contains_issue_reference?(payload["pull_request"]) && !authorIsAssigned) do
      %{
        error_type: @rule_name,
        actions: [
          %{
            remove_assignees: get_assignees_login(payload["pull_request"]["assignees"]),
            url: "#{payload["pull_request"]["issue_url"]}/assignees"
          },
          %{
            add_labels: ["in-progress"],
            url: "#{payload["pull_request"]["issue_url"]}/labels"
          },
          %{
            remove_label: "awaiting-review",
            url: "#{payload["pull_request"]["issue_url"]}/labels"
          },
          %{
            comment: error_message(payload["sender"]["login"]),
            url: payload["pull_request"]["comments_url"]
          },
          %{
            add_assignees: [ payload["sender"]["login"] ],
            url: "#{payload["pull_request"]["issue_url"]}/assignees"
          }
        ],
        wait: Helpers.wait(Mix.env, 30_000, 1000, 1),
        verify: true
      }
    else
      nil
    end
  end

  defp get_assignees_login(assignees) do
    assignees
    |> Enum.map(fn(a) -> a["login"] end)
  end

  @doc """
  iex>get_issue_base_url("https://api.github.com/repos/naazy/dwylbot-test/issues/29")
  "https://github.com/naazy/dwylbot-test/issues"
  """
  defp get_issue_base_url(api_issue_url) do
    api_issue_url
      |> String.replace("//api.", "//")
      |> String.split("/")
      |> Enum.filter(fn(a)-> a != "repos" end)
      |> Enum.drop(-1) #removes the issue number 29
      |> Enum.join("/")
  end

  @doc """
  iex>pr_contains_issue_reference(%{"body": "my comment #41")
  true
  iex>pr_contains_issue_reference(%{"body": "no issue ref")
  false
  iex>pr_contains_issue_reference(%{"body": "https://github.com/naazy/dwylbot-test/issues/29")
  true
  """
  defp pr_contains_issue_reference?(pr_data) do
    # shorthand means with # e.g. #41
    pr_contains_shorthand_issue_reference? = Regex.match?(~r/(#[0-9]+)\b/, pr_data["body"])
    || Regex.match?(~r/(#[0-9]+)\b/, pr_data["title"])

    issue_base_url =
      get_issue_base_url pr_data["issue_url"]

    compiled_issue_url_regex = case Regex.compile("(#{issue_base_url}\/[0-9]+)") do
      {:ok, string} -> string
      {:error, _reason} -> "error compiling regex"
    end

    pr_contains_url_issue_reference? = Regex.match?(compiled_issue_url_regex, pr_data["body"])
      || Regex.match?(compiled_issue_url_regex, pr_data["title"])

    pr_contains_shorthand_issue_reference? || pr_contains_url_issue_reference?
  end

  defp error_message(login) do
    """
    @#{login}, All pull requests must reference an issue but we cannot seem to find :mag: an issue URL in your pull request comment.

    Please edit :pencil2: your pull request comment and paste in a relevant issue URL.

    See our [contributing](https://github.com/dwyl/contributing) guide for more information :heart:

    Thanks for your contribution :sparkles:
    """
  end

end
