defmodule Virgule.Router do
  use Plug.Router

  plug(Plug.Static, at: "/css", from: "css")
  plug(:match)
  plug(:dispatch)

  @apiroute Application.compile_env(:virgule, :API_ROUTE)
  @adminroute Virgule.Config.adminroute()

  forward("/products", to: Virgule.ProductController)

  Plug.Router.get "/" do
    IO.inspect(@apiroute)
    Virgule.Admin.home(conn)
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "Not Found")
  end
end
