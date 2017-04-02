defmodule Dwylbot.RepoControllerTest do
  use Dwylbot.ConnCase

  # setup config do
  #   login_user(config)
  # end

  test "GET /repo - redirct to home page", %{conn: conn} do
    conn = get conn, "/repo"
    assert html_response(conn, 302) =~ "redirect"
  end

end