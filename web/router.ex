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
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/event", Dwylbot do
    pipe_through :api

    post "/new", EventController, :new
  end

end
