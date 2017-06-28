defmodule Dwylbot.MergeErrors do
  @moduledoc """
  GenServer, receive, merge and reports errors every 5s
  """
  use GenServer

  @github_api Application.get_env(:dwylbot, :github_api)

  def start_link(errors) do
    GenServer.start_link(__MODULE__, errors, name: __MODULE__)
  end

  def init(errors) do
    Process.send_after(self(), :errors, 1000)
    {:ok, errors}
  end

  def handle_info(:errors, errors) do
    GenServer.cast(self(), {:process_errors, errors})
    Process.send_after(self(), :errors, 5000)
    {:noreply, []}
  end

  def handle_cast({:process_errors, errors}, state) do
    errors
    |> Enum.each(fn(err) ->
      @github_api.report_error(err.token, err)
     end)

    {:noreply, state}
  end

  def handle_cast({:error, error}, errors) do
    {:noreply, [error | errors]}
  end
end
