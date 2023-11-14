defmodule Virgule.AdminController do
  @template_dir "lib/virgule/templates/admin"
  @adminroute Virgule.Config.adminroute()

  defp render(%{status: status} = conn, template, assigns) do
    body =
      @template_dir
      |> Path.join("layouts/default.html.eex")
      |> EEx.eval_file(
        content:
          @template_dir
          |> Path.join(template)
          |> String.replace_suffix(".html", ".html.eex")
          |> EEx.eval_file(assigns)
      )

    Plug.Conn.send_resp(conn, status || 200, body)
  end

  def home(conn) do
    render(conn, "index.html",
      products: Virgule.Product.getAll(),
      adminroute: @adminroute
    )
  end

  @spec product(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def product(conn, id) do
    product = Virgule.Product.get(id) |> Virgule.Repo.preload([:style_variants, :size_variants])
    IO.inspect(product)
    render(conn, "product.html", product: product, adminroute: @adminroute)
  end

  def add_product(conn) do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    params = URI.decode_query(body)
    price = Map.get(params, "price")
    name = Map.get(params, "name")
    Virgule.Product.add(name, price)

    render(conn, "feedback.html", adminroute: @adminroute, message: "Product added!")
  end

  def update_product(conn, id) do
    {:ok, body, _conn} = Plug.Conn.read_body(conn)
    params = URI.decode_query(body)
    Virgule.Product.update(id, params)
    render(conn, "feedback.html", adminroute: @adminroute, message: "Product updated!")
  end

  def delete_product(conn, id) do
    Virgule.Product.delete(id)
    render(conn, "feedback.html", adminroute: @adminroute, message: "Product deleted!")
  end
end
