defmodule DwylbotWeb.EventTestController do
  use DwylbotWeb.ConnCase
  alias Poison.Parser, as: PP
  alias Plug.Conn
  doctest DwylbotWeb.Rules.Helpers, import: true
  doctest DwylbotWeb.Rules.PR.ReviewerButNoAssignee, import: true

  @fixtures [
    %{payload: "add_label", event: "issues" },
    %{payload: "inprogress", event: "issues"},
    %{payload: "no_description", event: "issues" },
    %{payload: "unassigned_inprogress", event: "issues" },
    %{payload: "pr_no_description", event: "pull_request" },
    %{payload: "pr_merge_conflict", event: "pull_request" },
    %{payload: "pr_no_assignee_or_reviewer", event: "pull_request" },
    %{payload: "request_reviewer", event: "pull_request" },
    %{payload: "failing_test", event: "status" },
    %{payload: "pr_reviewer_but_no_assignee", event: "pull_request"}
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
end
