defmodule CartTest do
  use ExUnit.Case
  alias Virgule.Cart
  alias Virgule.Product

  setup do
    # Start the Cart GenServer before each test
    {:ok, _pid} = Cart.start_link(%{})
    :ok
  end

  test "add item to cart" do
    product = %Product{id: 1, name: "Book", price: 10.0}
    :ok = Cart.add_item(product)

    expected_cart_content = %{1 => [product]}
    assert Cart.get_contents() == expected_cart_content
  end

  test "retrieve empty cart contents" do
    assert Cart.get_contents() == %{}
  end

  test "handle multiple items" do
    product1 = %Product{id: 1, name: "Book", price: 10.0}
    product2 = %Product{id: 2, name: "Pen", price: 1.5}

    :ok = Cart.add_item(product1)
    :ok = Cart.add_item(product2)

    expected_cart_content = %{1 => [product1], 2 => [product2]}
    assert Cart.get_contents() == expected_cart_content
  end

  test "get cart amount" do
    product1 = %Product{id: 1, name: "Book", price: 10.0}
    product2 = %Product{id: 2, name: "Pen", price: 1.5}

    :ok = Cart.add_item(product1)
    :ok = Cart.add_item(product2)

    assert Cart.get_amount() == 11.5
  end
end