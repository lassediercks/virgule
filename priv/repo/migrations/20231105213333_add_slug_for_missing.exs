defmodule Merchy.Repo.Migrations.AddSlugForMissing do
  use Ecto.Migration

  def change do
    products = Merchy.Product |> Merchy.Repo.all()
      Enum.each(products, fn product ->
        Merchy.Product.update(product.id, %{slug: Merchy.Product.createSlug(product.name)})
      end)
  end
end
