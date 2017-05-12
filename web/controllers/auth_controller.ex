defmodule Dwylbot.AuthController do
  use Dwylbot.Web, :controller
  plug Ueberauth
  alias Dwylbot.SessionController

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user = basic_info(auth)
    SessionController.create(conn, user)
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Error while authenticating")
    |> redirect(to: "/")
  end

  defp basic_info(%{uid: username, credentials: %{token: token}}) do
    %{username: username, token: token}
  end
end
