defmodule PingWeb.Router do
  use PingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InertiaPhoenix.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PingWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
  end

  # Other scopes may use custom stacks.
  # scope "/api", PingWeb do
  #   pipe_through :api
  # end
end
