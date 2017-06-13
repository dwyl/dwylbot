defmodule Dwylbot.EventController do
  use Dwylbot.Web, :controller
  alias Dwylbot.Rules, as: DR
  @github_api Application.get_env(:dwylbot, :github_api)
  @duration Application.get_env(:dwylbot, :duration)

  def new(conn, params) do
    conn
    |> put_status(200)
    |> json(%{ok: "event received"})

    if params["sender"]["type"] != "Bot" do
      errors = DR.check(params["issue"], params["sender"]["login"])
      if !Enum.empty?(errors) do
        Process.sleep(@duration)
        token = @github_api.get_installation_token(params["installation"]["id"])
        issue_url = params["issue"]["url"]
        comments_url = params["issue"]["comments_url"]
        issue = @github_api.get_issue(token, issue_url)
        check_errors = DR.check(issue, "")
        errors_to_report = DR.compare(check_errors, errors)
        @github_api.report_error(token, errors_to_report, comments_url)
      end
    end

    conn
    |> put_status(:ok)
    |> json(%{sendback: true})
  end
end
