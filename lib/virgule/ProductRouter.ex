defmodule Virgule.ProductRouter do
  @moduledoc """
  Basic Products Dispatch Unit
  """
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/:id" do
    Virgule.Admin.product(conn, id)
  end

  post "/add" do
    Virgule.Admin.add_product(conn)
  end

  post "/update/:id" do
    Virgule.Admin.update_product(conn, id)
  end

  post "/delete/:id" do
    Virgule.Admin.delete_product(conn, id)
  end
end
