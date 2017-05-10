defmodule Dwylbot.Router do
  use Dwylbot.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Dwylbot.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dwylbot do
    pipe_through :browser

    get "/", PageController, :index
    get "/repo", RepoController, :index
    get "/repo/hooks", RepoController, :hooks
  end

  scope "/webhooks", Dwylbot do
    pipe_through :api
    post "/create", WebhooksController, :create
  end

  scope "/auth", Dwylbot do
    pipe_through :browser

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

end
