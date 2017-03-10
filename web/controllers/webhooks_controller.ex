defmodule Dwylbot.WebhooksController do
  use Dwylbot.Web, :controller

  def index(conn, _) do
    IO.puts "Welcome to dwylbot"
    render conn, "index.html"
  end

  def create(conn, params) do
    # params = Poison.decode!(payload["payload"])
    client = Tentacat.Client.new(%{access_token: System.get_env("GITHUB_ACCESS_TOKEN")})
    action = params["action"]
    labels = params["issue"]["labels"]
    assignees = params["issue"]["assignees"]
    owner = params["repository"]["owner"]["login"]
    repo = params["repository"]["name"]
    issue_id = params["issue"]["number"]
    invalid = action == "labeled" && contain_label?("in-progress", labels) && Enum.empty?(assignees)
    if invalid do
      IO.puts "Invalid in progress label"
      comment_body = %{"body" => "The label in-progress has been added without an assignee!"}
      Tentacat.Issues.Comments.create(owner, repo, issue_id, comment_body, client)
    else
      IO.puts "ok continue"
    end
    conn
    |> put_status(201)
    |> json(%{ok: true})
  end

  defp contain_label?(label, list_label) do
    list_label
    |> Enum.map(&(Map.get(&1, "name")))
    |> Enum.member?(label)
  end

end