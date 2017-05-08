defmodule Dwylbot.AuthController do
  use Dwylbot.Web, :controller
  plug Ueberauth
  alias Dwylbot.UserFromAuth

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user = UserFromAuth.basic_info(auth)
    conn
    |> put_flash(:info, "sucessfully authenticated")
    |> put_session(:current_user, user)
    |> redirect(to: page_path(conn, :index))
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Error while authenticating")
    |> redirect(to: "/")
  end
end
