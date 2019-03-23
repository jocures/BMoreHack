defmodule GohiremeWeb.Router do
  use GohiremeWeb, :router

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

  scope "/", GohiremeWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/signup", UserController
    resources "/login", UserSessionController, only: [:new, :create]
    delete "/logout", UserSessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", GohiremeWeb do
  #   pipe_through :api
  # end
end
