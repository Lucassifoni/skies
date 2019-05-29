defmodule SkiesWeb.PageController do
  use SkiesWeb, :controller

  def index(conn, _params) do
    conn
      |> assign(:images, GenServer.call(Skies.SkyviewServer, :images))
      |> render("index.html")
  end
end
