defmodule Dwylbot.WebhooksController do
  use Dwylbot.Web, :controller

  def index(conn, _) do
    IO.puts "Welcome to dwylbot"
    render conn, "index.html"
  end

  def create(conn, params) do
    action = params["action"]
    labels = params["issue"]["labels"]
    assignees = params["issue"]["assignees"]
    owner = params["repository"]["owner"]["login"]
    repo = params["repository"]["name"]
    issue_id = params["issue"]["number"]
    sender = params["sender"]["login"]

    invalid = action == "labeled" && contain_label?("in-progress", labels) && Enum.empty?(assignees)

    if invalid do
      client = Tentacat.Client.new(%{access_token: System.get_env("GITHUB_ACCESS_TOKEN")})
      comment_body = %{"body" => "@#{sender} the `in-progress` label has been added to this issue **without an Assignee**.
Please assign a user to this issue before applying the `in-progress` label."}
      Tentacat.Issues.Comments.create(owner, repo, issue_id, comment_body, client)
      conn
      |> put_status(201)
      |> json(%{ok: true})
    else
      conn
      |> put_status(200)
      |> json(%{ok: true})
    end
  end

  defp contain_label?(label, list_label) do
    list_label
    |> Enum.map(&(Map.get(&1, "name")))
    |> Enum.member?(label)
  end

end