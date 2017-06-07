defmodule Dwylbot.EventController do
  use Dwylbot.Web, :controller

  def new(conn, params) do
    IO.inspect params
    conn
    |> put_status(200)
    |> json(%{ok: true})
  end
end
