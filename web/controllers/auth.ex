defmodule Dwylbot.Auth do
  @moduledoc """
    Provide functions to authenticate a user
  """
  import Plug.Conn
  import Phoenix.Controller
  alias Dwylbot.Router.Helpers

  def init(_opts) do
  end

  def call(conn, _opts) do
    # this OR operator is used for our tests
    # the test assign values directly to the conn
    # instead of creating some fake sessions/cookies
    # see Chapter 8 page 137 the Programmin Phoenix book
    user = get_session(conn, :user) || conn.assigns[:user]
    if user do
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user, user)
    |> configure_session(renew: true)
  end
end
