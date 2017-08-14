defmodule Dwylbot.Rules.PR.AwaitingReview do
  @moduledoc """
  add awaiting-review if a reviewer has been added to the PR
  """
  alias Dwylbot.Rules.Helpers
  @github_api Application.get_env(:dwylbot, :github_api)
  @rule_name "pr_awaiting_review"

  def apply?(payload) do
    (payload["action"] == "review_requested")
  end

  def check(payload, _get_data?, token) do
    urls = %{
      "issue" => payload["pull_request"]["issue_url"],
      "pull_request" => payload["pull_request"]["url"]
      }
    payload = @github_api.get_data(token, urls, @rule_name)

    reviewers = payload["pull_request"]["requested_reviewers"]
    |> Enum.map(&(&1["login"]))

    in_progress = payload["issue"]["labels"]
    |> Helpers.label_member?("in-progress")

    url = Enum.join(["https://api.travis-ci.org/repos/", payload["pull_request"]["head"]["repo"]["full_name"], "/builds"])
    headers = ["Authorization": :GITHUB_TRAVIS_ACCESS_TOKEN, "Accept": "application/vnd.travis-ci.2+json", "User-Agent": "MyClient/1.0.0", "Content-Type": "application/json"]
    {:ok, response} = HTTPoison.get(url, headers)

    prBuild = (Poison.decode!(response.body))["builds"]
    |> Enum.find(fn(data) ->
      data["pull_request_number"] == payload["pull_request"]["number"]
      end)

    if (!Enum.empty?(reviewers) && !in_progress && (prBuild["state"] != "failed")) do
      %{
        error_type: @rule_name,
        actions: [
          %{
            add_labels: ["awaiting-review"],
            url: "#{payload["issue"]["url"]}/labels"
          },
          %{
            add_assignees: reviewers,
            url: "#{payload["issue"]["url"]}/assignees"
          },
          %{
            comment: error_message(payload["issue"]["user"]["login"]),
            url: payload["issue"]["comments_url"]
          },
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
    @#{login}, hoorah! 🎉  It's review time! 👀

    I couldn't help but notice that there isn't an `in-progress` label on this pull request and a **Reviewer**
    has been added...makes me think that this pull request is ready for review 🤔

    To save you time ⏳  I've added the **Reviewer** as an **Assignee** and I've added the `awaiting-review`
    label - automatically - just like magic! 🎩 🐰 ✨. Please correct me if I'm wrong, but if I got it right
    this time I hope it helps you! 😄 

    """
  end

end
