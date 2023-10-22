defmodule Virgule.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @adminroute Virgule.Config.adminroute()

  Plug.Router.get "/" do
    Virgule.Web.home(conn)
  end

  Plug.Router.get @adminroute do
    Virgule.Admin.home(conn)
  end

  Plug.Router.get "#{@adminroute}/product/:id" do
    Virgule.Admin.product(conn, id)
  end

  Plug.Router.get "/:slug" do
    Virgule.Web.product(conn, slug)
  end

  Plug.Router.post "#{@adminroute}/product/add" do
    Virgule.Admin.add_product(conn)
  end

  Plug.Router.post "#{@adminroute}/product/update/:id" do
    Virgule.Admin.update_product(conn, id)
  end

  Plug.Router.post "#{@adminroute}/product/delete/:id" do
    Virgule.Admin.delete_product(conn, id)
  end

  Plug.Router.match _ do
    Virgule.Web.fourofour(conn)
  end
end
