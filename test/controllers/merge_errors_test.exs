defmodule Dwylbot.MergeErrorsTest do
  use ExUnit.Case

  test "send error" do
    error = %{
      token: 42,
      error_type: "issue_inprogress_noassignees",
      actions: [
        %{
          comment: "test comment",
          url: ""
        },
      ]
    }
    assert :ok == Dwylbot.MergeErrors.send_error(error)
    Process.sleep(1000)
  end

end
