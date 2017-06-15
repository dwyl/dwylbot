defmodule Dwylbot.EventTestController do
  use Dwylbot.ConnCase
  alias Poison.Parser, as: PP

  test "POST /event/new - no error", %{conn: conn} do
    payload = "./test/fixtures/add_label.json"
    |> File.read!()
    |> PP.parse!()
    conn = post conn, "/event/new", payload
    assert json_response(conn, 200)
  end

  test "POST /event/new - in progress, no assignees", %{conn: conn} do
    payload = "./test/fixtures/inprogress.json"
    |> File.read!()
    |> PP.parse!()
    conn = post conn, "/event/new", payload
    assert json_response(conn, 200)
  end

  test "POST /event/new - new issue without description", %{conn: conn} do
    payload = "./test/fixtures/no_description.json"
    |> File.read!()
    |> PP.parse!()
    conn = post conn, "/event/new", payload
    assert json_response(conn, 200)
  end

  test "POST /event/new - unassigned with inprogress", %{conn: conn} do
    payload = "./test/fixtures/unassigned_inprogress.json"
    |> File.read!()
    |> PP.parse!()
    conn = post conn, "/event/new", payload
    assert json_response(conn, 200)
  end

end
