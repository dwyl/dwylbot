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
    # "https://api.github.com/repos/naazy/dwylbot-test/issues/29"
    # -> https://github.com/naazy/dwylbot-test/issues/41
    issue_base_url =
      payload["pull_request"]["issue_url"]
        |> String.replace("//api.", "//")
        |> String.split("/")
        |> Enum.filter(fn(a)-> a != "repos" end)
        |> Enum.drop(-1) #removes the issue number 29
        |> Enum.join("/")

    assignees = get_assignees_login(payload["pull_request"]["assignees"])

    authorIsAssigned = Enum.member?(assignees, payload["pull_request"]["base"]["user"]["login"])

    pr_contains_shorthand_issue_reference? = Regex.match?(~r/(#[0-9]+)\b/, payload["pull_request"]["body"])

    compiled_issue_url_regex = case Regex.compile("(#{issue_base_url}\/[0-9]+)") do
      {:ok, string} -> string
      {:error, _reason} -> "error compiling regex"
    end

    pr_contains_url_issue_reference? = Regex.match?(compiled_issue_url_regex, payload["pull_request"]["body"])

    if (!(pr_contains_shorthand_issue_reference? || pr_contains_url_issue_reference?) && !authorIsAssigned) do
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

  defp error_message(login) do
    """
    @#{login}, All pull requests must reference an issue but we cannot seem to find :mag: an issue URL in your pull request comment.

    Please edit :pencil2: your pull request comment and paste in a relevant issue URL.

    See our [contributing](https://github.com/dwyl/contributing) guide for more information :heart:

    Thanks for your contribution :sparkles:
    """
  end

end
