defmodule Dwylbot.EventController do
  use Dwylbot.Web, :controller
  alias Dwylbot.WaitProcess, as: WAIT
  alias Plug.Conn

  def new(conn, params) do
    [event_type | _] = Conn.get_req_header conn, "x-github-event"
    spawn(WAIT, :delay, [params, event_type])
    conn
    |> put_status(200)
    |> json(%{ok: "event received"})
  end
end
