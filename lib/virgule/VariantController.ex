defmodule Virgule.VariantController do
  # def changeset(variant, params \\ %{}) do
  #   variant
  #   |> Ecto.Changeset.cast(params, [:name, :price, :product_id])
  #   |> Ecto.Changeset.validate_required([:name, :price, :product_id])
  # end
end

defmodule Virgule.StyleVariants do
  use Ecto.Schema

  schema "style_variants" do
    field(:name, :string)
    field(:price, :float)
    belongs_to(:product, Virgule.Product)
  end

  def changeset(variant, params \\ %{}) do
    variant
    |> Ecto.Changeset.cast(params, [:name, :price, :product_id])
    |> Ecto.Changeset.validate_required([:name, :price, :product_id])
  end

  def add(name, price, product_id) do
    {price, _} = Float.parse(price)
    variant = %Virgule.StyleVariants{name: name, price: price, product_id: product_id}
    changeset = Virgule.StyleVariants.changeset(variant)
    Virgule.Repo.insert(changeset)
  end
end

defmodule Virgule.SizeVariants do
  use Ecto.Schema

  schema "size_variants" do
    field(:name, :string)
    field(:price, :float)
    belongs_to(:product, Virgule.Product)
  end
end
