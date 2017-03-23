defmodule Dwylbot.WebhooksControllerTest do
  use Dwylbot.ConnCase
  @root_dir File.cwd!
  @data_bug Path.join(~w(#{@root_dir} test/fixtures dwylbot-test-bug-label.json))
  @data_in_progress Path.join(~w(#{@root_dir} test/fixtures dwylbot-test.json))

  test "GET /webhooks", %{conn: conn} do
    conn = get conn, "/webhooks"
    assert html_response(conn, 200) =~ "Welcome to dwylbot"
  end

  test "POST /webhooks/create with label bug (no comment added by dwylbot)", %{conn: conn} do
    data = @data_bug
           |> File.read!
           |> Poison.decode!
    conn = post conn, "/webhooks/create", data
    IO.inspect conn.resp_body
    assert json_response(conn, 200)
  end

  test "POST /webhooks/create with label in-progress", %{conn: conn} do
    data = @data_in_progress
           |> File.read!
           |> Poison.decode!
    conn = post conn, "/webhooks/create", data
    assert json_response(conn, 201)
  end
end
