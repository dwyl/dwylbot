defmodule Dwylbot.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias Dwylbot.Router.Helpers

  def init(_opts) do
  end

  def call(conn, _opts) do
    # this OR operator is used for our tests
    # the test assign values directly to the conn instead of creating some fake sessions/cookies
    # see Chapter 8 page 137 section Integration Tests of the Programmin Phoenix book
    user = get_session(conn, :current_user) || conn.assigns[:current_user]
    cond do
      user ->
        assign(conn, :current_user, user)
      true ->
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
end
