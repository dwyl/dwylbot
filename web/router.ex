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
    resources "/installation", InstallationController, only: [:index, :show]
  end

  scope "/auth", Dwylbot do
    pipe_through :browser

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/event", Dwylbot do
    pipe_through :api
    post "/new", EventController, :new
  end

end
