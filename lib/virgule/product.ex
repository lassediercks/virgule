defmodule Virgule.Product do
  alias Virgule.VariantController
  use Ecto.Schema

  @derive {Jason.Encoder, only: [:name, :price, :slug, :id, :style_variants, :size_variants]}

  schema "products" do
    field(:name, :string)
    field(:price, :float)
    field(:slug, :string)
    has_many(:style_variants, Virgule.StyleVariants, foreign_key: :product_id)
    has_many(:size_variants, Virgule.SizeVariants, foreign_key: :product_id)
  end

  @spec createSlug(binary()) :: binary()
  def createSlug(name) do
    name |> String.downcase() |> String.replace(" ", "-")
  end

  def add(name, price) do
    {price, _} = Float.parse(price)
    product = %Virgule.Product{name: name, price: price, slug: createSlug(name)}
    changeset = Virgule.Product.changeset(product)
    Virgule.Repo.insert(changeset)
  end

  def delete(id) do
    person = Virgule.Repo.get(Virgule.Product, id)
    Virgule.Repo.delete(person)
  end

  def changeset(product, params \\ %{}) do
    product
    |> Ecto.Changeset.cast(params, [:name, :price, :slug])
    |> Ecto.Changeset.validate_required([:name, :price, :slug])
  end

  def get(id) do
    Virgule.Product |> Virgule.Repo.get(id)
  end

  def update(id, params) do
    product = get(id)
    Virgule.Repo.update(changeset(product, params))
  end

  # Get all products
  def getAll do
    Virgule.Product |> Virgule.Repo.all()
  end
end
