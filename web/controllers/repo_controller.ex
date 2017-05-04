defmodule Dwylbot.RepoController do
  use Dwylbot.Web, :controller

  plug :authenticate_user when action in [:index]

  def index(conn, _) do
    user = get_session(conn, :current_user)
    client = Tentacat.Client.new(%{access_token: user.token})
    repos = Tentacat.Repositories.list_mine(client, type: "owner")
    render conn, "index.html", repos: repos
  end

  def hooks(conn, _) do
    user = get_session(conn, :current_user)
    client = Tentacat.Client.new(%{access_token: user.token})
    hooks = Tentacat.Hooks.list("dwyl", "dwylbot", client)
    IO.inspect hooks
    render conn, "hooks.html", hooks: hooks
  end
end