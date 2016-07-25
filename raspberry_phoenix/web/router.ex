defmodule RaspberryPhoenix.Router do
  use RaspberryPhoenix.Web, :router

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

  scope "/", RaspberryPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
   # get "/alarms", AlarmsController, :alarms
  end

  # Other scopes may use custom stacks.
   scope "/api", RaspberryPhoenix do
     pipe_through :api
     get "/alarms", AlarmsController, :alarms
     resources "/alarms", AlarmsController
     post "/alarm", AlarmsController, :alarm
   end
end
