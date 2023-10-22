defmodule Merchy.Repo.Migrations.AddSlugForAll do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :slug, :string
    end


  end



end
