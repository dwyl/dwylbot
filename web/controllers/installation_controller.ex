defmodule Dwylbot.InstallationController do
  use Dwylbot.Web, :controller

  plug :authenticate_user when action in [:index]
  @github_api Application.get_env(:dwylbot, :github_api)

  def index(conn, _params) do
    token = conn.assigns.current_user.token
    installations = @github_api.get_installations(token)
    render conn, "index.html", installations: installations
  end
end
