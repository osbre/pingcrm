defmodule PingWeb.Router do
  use PingWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PingWeb.Plugs.InertiaShare
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
    get "/500", DashboardController, :error_500
    get "/404", DashboardController, :error_404

    get "/", DashboardController, :index

    resources "/users", UserController do
      put "/restore", UserController, :restore, as: :restore
    end

    delete "/logout", Users.SessionController, :delete, as: :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", PingWeb do
  #   pipe_through :api
  # end
end
