defmodule Virgule.ApiController do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/products" do
    products = Virgule.Product.getAll() |> Jason.encode!()
    Plug.Conn.send_resp(conn, 200, products)
  end

  get "/products/:id" do
    product = Virgule.Product.get(id) |> Jason.encode!()
    Plug.Conn.send_resp(conn, 200, product)
  end
end
