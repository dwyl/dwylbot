defmodule DwylbotWeb.PageController do
  use DwylbotWeb, :controller

  def index(conn, _params) do
    user = conn.assigns[:current_user]
    app_name = System.get_env("GITHUB_APP_NAME")
    render conn, "index.html", current_user: user, app_name: app_name
  end
end
