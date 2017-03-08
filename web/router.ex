defmodule Dwylbot.Router do
  use Dwylbot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dwylbot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/webhooks", WebhooksController, :index

  end

  scope "/webhooks", Dwylbot do
    pipe_through :api
    post "/create", WebhooksController, :create
  end

end
