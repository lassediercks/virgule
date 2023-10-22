defmodule MerchyTest do
  use ExUnit.Case
  doctest Merchy

  test "greets the world" do
    assert Merchy.hello() == :world
  end

  test "create slug" do
    assert Merchy.Product.createSlug("This is sparta") == "this-is-sparta"
  end
end
