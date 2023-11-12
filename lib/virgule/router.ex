defmodule Virgule.Router do
  use Plug.Router

  plug(Plug.Static, at: "/css", from: "css")
  plug(:match)
  plug(:dispatch)

  @adminroute Virgule.Config.adminroute()

  Plug.Router.get "/" do
    Virgule.Admin.home(conn)
  end

  Plug.Router.get "/product/:id" do
    Virgule.Admin.product(conn, id)
  end

  Plug.Router.post "/product/add" do
    Virgule.Admin.add_product(conn)
  end

  Plug.Router.post "/product/update/:id" do
    Virgule.Admin.update_product(conn, id)
  end

  Plug.Router.post "/product/delete/:id" do
    Virgule.Admin.delete_product(conn, id)
  end

  Plug.Router.match _ do
    Plug.Conn.send_resp(conn, 404, "Not Found")
  end
end
