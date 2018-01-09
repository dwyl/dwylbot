defmodule DwylbotWeb.EventController do
  use DwylbotWeb, :controller
  alias DwylbotWeb.WaitProcess, as: WAIT
  alias Plug.Conn
  alias DwylbotWeb.Rules

  @github_api Application.get_env(:dwylbot, :github_api)

  def new(conn, payload) do
    token = @github_api.get_installation_token(payload["installation"]["id"])
    [event_type | _] = Conn.get_req_header conn, "x-github-event"
    errors = Rules.apply_and_check_errors(payload, event_type, token)
    errors
    |> Enum.each(fn(error) ->
         spawn(WAIT, :delay, [error, payload, event_type, token])
       end)
    conn
    |> put_status(200)
    |> json(%{ok: "event received"})
  end
end
