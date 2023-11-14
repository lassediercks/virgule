defmodule Virgule.ProductRouter do
  @moduledoc """
  Basic Products Dispatch Unit
  """
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/:id" do
    Virgule.AdminController.product(conn, id)
  end

  post "/add" do
    Virgule.AdminController.add_product(conn)
  end

  post "/update/:id" do
    Virgule.AdminController.update_product(conn, id)
  end

  post "/delete/:id" do
    Virgule.AdminController.delete_product(conn, id)
  end
end
