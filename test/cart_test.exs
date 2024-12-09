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

    expected_cart_content = %{1 => {product, 1}}
    assert Cart.get_contents() == expected_cart_content
  end

  test "increase quantity of cart item" do
    product = %Product{id: 1, name: "Book", price: 10.0}
    :ok = Cart.add_item(product)

    Cart.update_quantity(1, 5)

    assert Cart.get_contents() == %{
             1 => {%Product{id: 1, name: "Book", price: 10.0}, 6}
           }
  end

  test "retrieve empty cart contents" do
    assert Cart.get_contents() == %{}
  end

  test "handle multiple items" do
    product1 = %Product{id: 1, name: "Book", price: 10.0}
    product2 = %Product{id: 2, name: "Pen", price: 1.5}

    :ok = Cart.add_item(product1)
    :ok = Cart.add_item(product2)

    expected_cart_content = %{1 => {product1, 1}, 2 => {product2, 1}}
    assert Cart.get_contents() == expected_cart_content
  end

  test "get cart amount" do
    product1 = %Product{id: 1, name: "Book", price: 10.0}
    product2 = %Product{id: 2, name: "Pen", price: 1.5}

    :ok = Cart.add_item(product1)
    :ok = Cart.add_item(product2)
    :ok = Cart.add_item(product2)

    assert Cart.get_amount() == 13
  end

  test "get cart amount with 1 product" do
    product1 = %Product{id: 1, name: "Book", price: 10.0}

    :ok = Cart.add_item(product1)

    assert Cart.get_amount() == 10
  end
end
