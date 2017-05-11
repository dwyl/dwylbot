defmodule Dwylbot.AuthController do
  use Dwylbot.Web, :controller
  plug Ueberauth
  alias Dwylbot.{UserFromAuth, User, Repo}

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_auth = UserFromAuth.basic_info(auth)
    changeset = User.changeset(%User{}, user_auth)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "sucessfully signup")
        |> put_session(:current_user, user_auth)
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:info, "sucessfully signin")
        |> put_session(:current_user, user_auth)
        |> redirect(to: page_path(conn, :index))
    end

  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Error while authenticating")
    |> redirect(to: "/")
  end
end
