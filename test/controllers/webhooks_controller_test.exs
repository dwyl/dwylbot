defmodule Dwylbot.WebhooksControllerTest do
  use Dwylbot.ConnCase

  test "GET /webhooks", %{conn: conn} do
    conn = get conn, "/webhooks"
    assert html_response(conn, 200) =~ "Welcome to dwylbot"
  end

  # test "POST /webhooks/create", %{conn: conn} do
  #   conn = post conn, "/webhooks/create", %{event: "label"}
  #   assert json_response(conn, 201)
  #
  # end
end
