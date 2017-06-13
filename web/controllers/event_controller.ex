defmodule Dwylbot.EventController do
  use Dwylbot.Web, :controller
  alias Dwylbot.Rules, as: DR
  alias Dwylbot.WaitProcess, as: DW
  @github_api Application.get_env(:dwylbot, :github_api)
  @duration Application.get_env(:dwylbot, :duration)

  def new(conn, params) do
    spawn(DW, :delay, [params])
    conn
    |> put_status(200)
    |> json(%{ok: "event received"})
  end
end
