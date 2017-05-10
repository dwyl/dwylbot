defmodule Dwylbot.RepoController do
  use Dwylbot.Web, :controller
  alias Tentacat.{Client, Repositories, Hooks}
  plug :authenticate_user when action in [:index]

  def index(conn, _) do
    user = get_session(conn, :current_user)
    client = Client.new(%{access_token: user.token})
    repos = Repositories.list_mine(client, type: "owner")
    render conn, "index.html", repos: repos
  end

  def hooks(conn, _) do
    user = get_session(conn, :current_user)
    client = Client.new(%{access_token: user.token})
    hooks = Hooks.list("dwyl", "dwylbot", client)
    render conn, "hooks.html", hooks: hooks
  end
end
