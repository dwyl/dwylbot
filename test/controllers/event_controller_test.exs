defmodule Dwylbot.EventTestController do
  use Dwylbot.ConnCase
  alias Poison.Parser, as: PP
  alias Plug.Conn
  alias Dwylbot.Rules.Helpers

  @fixtures [
    %{payload: "add_label", event: "issues" },
    %{payload: "inprogress", event: "issues"},
    %{payload: "no_description", event: "issues" },
    %{payload: "unassigned_inprogress", event: "issues" },
    %{payload: "pr_no_description", event: "pull_request" }
  ]
  |> Enum.map(&(%{&1 | payload: "./test/fixtures/#{&1.payload}.json"}))

  test "POST /event/new", %{conn: conn} do
    for fixture <- @fixtures do
      payload = fixture.payload |> File.read! |> PP.parse!
      conn = conn
      |> Conn.put_req_header("x-github-event", "#{fixture.event}")
      |> post("/event/new", payload)
      assert json_response(conn, 200)
    end
  end

  test "helper wait", _conn do
      assert Helpers.wait(:prod, 1, 2, 3) == 1
      assert Helpers.wait(:dev, 1, 2, 3) == 2
      assert Helpers.wait(:test, 1, 2, 3) == 3
  end
end
