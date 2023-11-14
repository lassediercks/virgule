defmodule Virgule.Router do
  use Plug.Router

  plug(Plug.Static, at: "/css", from: "css")
  plug(:match)
  plug(:dispatch)

  @apiroute Application.compile_env(:virgule, :API_ROUTE)

  forward("/products", to: Virgule.ProductRouter)
  forward(@apiroute, to: Virgule.ApiController)

  Plug.Router.get "/" do
    IO.inspect(@apiroute)
    Virgule.AdminController.home(conn)
  end

  match _ do
    Plug.Conn.send_resp(conn, 404, "Not Found")
  end
end
