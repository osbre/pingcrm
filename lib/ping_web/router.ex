defmodule PingWeb.Router do
  use PingWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug InertiaPhoenix.Plug
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: PingWeb.AuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: PingWeb.AuthErrorHandler
  end

  # https://hexdocs.pm/pow/custom_controllers.html
  scope "/", PingWeb.Users do
    pipe_through [:browser, :not_authenticated]

    # get "/signup", RegistrationController, :new, as: :signup
    # post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", PingWeb do
    pipe_through [:browser, :protected]

    get "/", PageController, :index
    delete "/logout", SessionController, :delete, as: :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", PingWeb do
  #   pipe_through :api
  # end
end
