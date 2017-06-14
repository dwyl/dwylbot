defmodule Dwylbot.EventController do
  use Dwylbot.Web, :controller
  alias Dwylbot.WaitProcess, as: DW

  def new(conn, params) do
    spawn(DW, :delay, [params])
    conn
    |> put_status(200)
    |> json(%{ok: "event received"})
  end
end
