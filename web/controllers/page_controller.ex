defmodule Dwylbot.PageController do
  use Dwylbot.Web, :controller

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    render conn, "index.html", current_user: user
  end
end
