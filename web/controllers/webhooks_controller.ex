defmodule Dwylbot.WebhooksController do
  use Dwylbot.Web, :controller

  def index(conn, _) do
    IO.puts "Welcome to dwylbot"
    render conn, "index.html"
  end

  def create(conn, %{"payload" => payload}) do
    IO.puts "Post request to /webhooks received!"
    %{"action" => action,  "issue" => %{"labels" => labels, "assignees" => assignees}} = Poison.decode!(payload)
    invalid = action == "labeled" && contain_label?("in-progress", labels) && Enum.empty?(assignees)

    if invalid do
      IO.puts "Invalid in progress label"
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