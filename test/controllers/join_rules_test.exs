defmodule Dwylbot.JoinRulesTest do
  alias Dwylbot.Rules.Join
  use ExUnit.Case
  doctest Dwylbot.Rules.Join.EstimationAssignee, import: true

  test "Join errors" do
    errors = [
      %{
        actions: [
          %{comment: "conment_1",
            url: "https://api.github.com/repos/SimonLab/github_app/issues/26/comments"
            }
          ],
        error_type: "issue_no_estimation",
        id: "SimonLab/github_app/26",
        token: 42,
        },
      %{
        actions: [
          %{comment: "conment_2",
            url: "https://api.github.com/repos/SimonLab/github_app/issues/26/comments"
           }],
        error_type: "issue_inprogress_noassignees",
        id: "SimonLab/github_app/26",
        token: 42,
        },
      %{
        actions: [
          %{comment: "conment_3",
            url: "https://api.github.com/repos/SimonLab/github_app/issues/25/comments"
           }],
        error_type: "another_error",
        id: nil,
        token: 42,
        },
    ]

    expected  = [
      %{
        actions: [
          %{comment: "conment_2\n\nconment_1\n",
            url: "https://api.github.com/repos/SimonLab/github_app/issues/26/comments"
            }
          ],
        token: 42,
        },
      %{
        actions: [
          %{comment: "conment_3",
            url: "https://api.github.com/repos/SimonLab/github_app/issues/25/comments"
           }],
        error_type: "another_error",
        id: nil,
        token: 42,
        },
    ]

    assert expected == Join.join(errors)
  end
end
