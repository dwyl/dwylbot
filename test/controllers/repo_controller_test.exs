defmodule Dwylbot.RepoControllerTest do
  use Dwylbot.ConnCase

  test "GET /repo - redirct to home page", %{conn: conn} do
    conn = get conn, "/repo"
    assert html_response(conn, 302) =~ "redirect"
  end

end
