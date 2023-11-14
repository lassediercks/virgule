defmodule Virgule.Repo.Migrations.IntroduceVariations do
  use Ecto.Migration

  def change do
    create table(:size_variants) do
      add(:name, :string)
      add(:price, :float)
      add(:product_id, references(:products, on_delete: :delete_all))
    end
    create table(:style_variants) do
      add(:name, :string)
      add(:price, :float)
      add(:product_id, references(:products, on_delete: :delete_all))
    end
  end
end
