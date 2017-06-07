defmodule Dwylbot.PageControllerTest do
  use Dwylbot.ConnCase
  setup %{conn: conn} = config do
    if name = config[:login_as] do
      user = %{username: name, token: "1"}
      conn = assign(conn, :user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to dwylbot"
  end

  @tag login_as: "Simon"
  test "GET / - user authenticated", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome Simon"
  end
end
