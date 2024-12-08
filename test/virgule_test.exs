defmodule VirguleTest do
  use ExUnit.Case
  doctest Virgule

  test "greets the world" do
    assert Virgule.hello() == :world
  end

  test "creates a product" do
    assert Virgule.Product.create("Product 1", 100) ==
             {:ok, %Virgule.Product{name: "Product 1", price: 100}}
  end
end
