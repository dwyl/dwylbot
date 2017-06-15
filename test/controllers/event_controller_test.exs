defmodule Dwylbot.EventTestController do
  use Dwylbot.ConnCase
  alias Poison.Parser, as: PP

  @fixtures ~w(add_label
               inprogress
               no_description
               unassigned_inprogress)
            |> Enum.map(&("./test/fixtures/#{&1}.json"))

  test "POST /event/new", %{conn: conn} do
    for fixture <- @fixtures do
      payload = fixture |> File.read! |> PP.parse!
      conn = post conn, "/event/new", payload
      assert json_response(conn, 200)
    end
  end
end
