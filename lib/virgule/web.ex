defmodule Virgule.Web do
  @template_dir "lib/virgule/templates/web"

  defp render(%{status: status} = conn, template, assigns \\ [], layout \\ "default") do
    body =
      @template_dir
      |> Path.join("layouts/#{layout}.html.eex")
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
    render(conn, "index.html", products: Virgule.Product.getAll())
  end

  def product(conn, slug) do
    product = Virgule.Product |> Virgule.Repo.get_by(slug: slug)

    case product do
      nil -> fourofour(conn)
      _ -> render(conn, "product.html", product: product)
    end
  end

  def fourofour(conn) do
    render(conn, "404.html")
  end
end
