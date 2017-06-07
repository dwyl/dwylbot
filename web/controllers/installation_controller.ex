defmodule Dwylbot.InstallationController do
  use Dwylbot.Web, :controller

  plug :authenticate_user when action in [:index]

  def index(conn, _params) do
    render conn, "index.html"
  end
end
