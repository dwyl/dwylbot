defmodule DwylbotWeb.Rules.PR.ReviewerButNoAssignee do
  @moduledoc """
  Check for error when an PR has awaiting-review but no assignees
  """
  alias DwylbotWeb.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_reviewer_but_no_assignee"

  def apply?(payload) do
    reviewers = payload["pull_request"]["requested_reviewers"]  |> Enum.map(&(&1["login"]))
    payload["action"] in ~w(labeled unassigned assigned) && !Enum.empty?(reviewers)
  end

  def check(payload, _get_data?, token) do
    reviewers = payload["pull_request"]["requested_reviewers"]  |> Enum.map(&(&1["login"]))
    author_event = payload["sender"]["login"]
    url = payload["pull_request"]["issue_url"]
    payload = @github_api.get_data(token, %{"issue" => url}, @rule_name)
    labels = payload["issue"]["labels"]
    assignees = payload["issue"]["assignees"]
    author = payload["issue"]["user"]["login"]
    incorrect_assignee = wrong_assignee(assignees, author)
    if Helpers.label_member?(labels, "awaiting-review") && incorrect_assignee do
      %{
        error_type: @rule_name,
        actions: [
          %{
            comment: error_message(author_event),
            url: payload["issue"]["comments_url"]
          },
          %{
            add_assignees: [reviewers],
            url: "#{payload["issue"]["url"]}/assignees"
          }
        ],
        wait: Helpers.wait(Mix.env, 30_000, 1000, 1),
        verify: true
      }
    else
      nil
    end
  end

  defp error_message(login) do
    """
    :wave: @#{login}, you have requested a review for this pull request so we have taken the liberty of assigning the reviewers :tada:.

    Have a great day :sunny: and keep up the good work :computer: :clap:
    """
  end

  @doc """
  iex>wrong_assignee([],"SimonLab")
  true
  iex>wrong_assignee([%{"login" => "SimonLab"}], "naazy")
  false
  iex>wrong_assignee([%{"login" => "iteles"},%{"login" => "naazy"}], "naazy")
  false
  iex>wrong_assignee([%{"login" => "iteles"}],"iteles")
  true
  iex>wrong_assignee([%{"login" => "naazy"}, %{"login" => "iteles"}],"iteles")
  false
  """

  def wrong_assignee(assignees, login) do
    case length(assignees) do
      0 -> true
      1 ->
        name = assignees
        |> List.first()
        |> Map.get("login")

        (name == login)
      _ -> false
    end
  end

end
