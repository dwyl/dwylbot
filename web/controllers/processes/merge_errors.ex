defmodule Dwylbot.MergeErrors do
  @moduledoc """
  GenServer, receive, merge and reports errors every 5s
  """
  use GenServer
  alias Dwylbot.Rules.Join
  @github_api Application.get_env(:dwylbot, :github_api)
  @time Application.get_env(:dwylbot, :time_merge_errors)

  def start_link(errors) do
    GenServer.start_link(__MODULE__, errors, name: __MODULE__)
  end

  def init(errors) do
    process_errors()
    {:ok, errors}
  end

  def process_errors do
    Process.send(__MODULE__, :errors, [])
  end

  def send_error(error) do
    GenServer.cast(__MODULE__, {:error, error})
  end

  def handle_info(:errors, errors_state) do
    GenServer.cast(__MODULE__, {:report_errors, errors_state})
    Process.send_after(__MODULE__, :errors, @time)
    {:noreply, []}
  end

  def handle_cast({:report_errors, errors}, errors_state) do
    joined_errors = Join.join(errors)
    joined_errors
    |> Enum.each(fn(err) ->
      @github_api.report_error(err.token, err)
     end)

    {:noreply, errors_state}
  end

  def handle_cast({:error, error}, errors_state) do
    {:noreply, [error | errors_state]}
  end
end
