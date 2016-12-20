defmodule BigSnips.Router do
  use BigSnips.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BigSnips.Auth, repo: BigSnips.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BigSnips do
    pipe_through :browser # Use the default browser stack

    get "/", PostController, :index
    resources "/users", UserController
    resources "/posts", PostController
    resources "/snippets", SnippetController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/posts/user/:id", PostController, :user
  end

  # Other scopes may use custom stacks.
  # scope "/api", BigSnips do
  #   pipe_through :api
  # end
end
