defmodule DwylbotWeb.PageControllerTest do
  use DwylbotWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to dwylbot"
  end

end
