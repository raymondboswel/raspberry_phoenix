defmodule RaspberryPhoenix.PageController do
  use RaspberryPhoenix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
