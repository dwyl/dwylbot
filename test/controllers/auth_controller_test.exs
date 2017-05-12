defmodule Dwylbot.AuthControllerTest do
  use Dwylbot.ConnCase
  alias Ueberauth.Auth

  test "GET /auth/github/callback", %{conn: conn} do
    conn = put_in(conn.assigns, %{ueberauth_auth: %Auth{}})
    conn = get conn, "/auth/github/callback"

    assert html_response(conn, 302) =~ "redirected"
    assert get_session(conn, :user)
    assert get_flash(conn, :info) =~ "Successful signup, welcome to dwylbot!"
  end

  test "GET /auth/github/callback - with errors", %{conn: conn} do
    conn = get conn, "/auth/github/callback"
    assert html_response(conn, 302) =~ "redirected"
    assert get_flash(conn, :error) =~ "Error while authenticating"
  end

  test "DELETE /auth/logout", %{conn: conn} do
    conn = put_in(conn.assigns, %{ueberauth_auth: %Auth{}})
    conn = get conn, "/auth/github/callback"
    conn = delete conn, "/auth/logout"

    assert get_flash(conn, :info) =~ "You have been logged out!"
    assert html_response(conn, 302) =~ "redirected"
    assert conn.private[:plug_session_info] == :drop
  end
end
