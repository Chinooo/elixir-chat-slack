defmodule Chat.Router do
  use Chat.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chat do
    pipe_through :api
    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    resources "/users", UserController, except: [:edit]
    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/user_rooms", UserRoomController, except: [:new, :edit]
  end
end
