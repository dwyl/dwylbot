defmodule Dwylbot.InstallationControllerTest do
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

  test "GET /installation - redirect to home page not logged in", %{conn: conn} do
    conn = get conn, "/installation"
    assert html_response(conn, 302) =~ "redirect"
  end

  @tag login_as: "Simon"
  test "GET /installation - list dwylbot installation", %{conn: conn} do
    conn = get conn, "/installation"
    response = assert html_response(conn, 200)
    assert response =~ "List of dwylbot installations"
    assert response =~ "dwyl"
    assert response =~ "FocusHub"
  end

  test "GET /installation/1 - redirect to home page not logged in", %{conn: conn} do
    conn = get conn, "/installation/1"
    assert html_response(conn, 302) =~ "redirect"
  end

  @tag login_as: "Simon"
  test "GET /installation/1 - list repos for instllations 1 where dwylbot is active", %{conn: conn} do
    conn = get conn, "/installation/1"
    response = assert html_response(conn, 200)
    assert response =~ "List of repositories with dwylbot active"
    assert response =~ "learn-elixir"
  end

end
