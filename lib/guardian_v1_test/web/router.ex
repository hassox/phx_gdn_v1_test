defmodule GuardianV1Test.Web.Router do
  use GuardianV1Test.Web, :router

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

  pipeline :maybe_auth do
    plug GuardianV1Test.Guardian.MaybePipeline
  end

  pipeline :auth_access do
    plug GuardianV1Test.Guardian.AccessPipeline
  end

  scope "/", GuardianV1Test.Web do
    pipe_through [:browser, :maybe_auth] # Use the default browser stack

    get "/", PageController, :index
    get "/login", PageController, :login
    post "/login", AuthController, :create
    post "/logout", AuthController, :logout

    resources "/users", UserController, only: [:new, :create]
  end

  scope "/protected", GuardianV1Test.Web do
    pipe_through [:browser, :auth_access]

    get "/", PageController, :protected

    resources "/users", UserController, except: [:new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", GuardianV1Test.Web do
  #   pipe_through :api
  # end
end
