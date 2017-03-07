defmodule Dwylbot.WebhooksController do
  use Dwylbot.Web, :controller

  def index(conn, _) do
    IO.puts "Welcome to dwylbot"
    render conn, "index.html"
  end

  def create(conn, _) do
    IO.puts "Post request to /webhooks received!"
    json conn, %{response: :ok}
  end
end