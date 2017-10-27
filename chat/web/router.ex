defmodule Chat.Router do
  use Chat.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Chat do
    pipe_through :api
  end
end
