defmodule Virgule do
  @moduledoc """
  Documentation for `Virgule`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Virgule.hello()
      :world

  """
  def hello do
    :world
  end

  defmodule Product do
    defstruct id: "", name: "", price: 0

    @moduledoc """
    Documentation for `Product`.
    """

    @doc """
    Creates a product.

    ## Examples

        iex> Product.create_product("Product 1", 100)
        {:ok, %Product{name: "Product 1", price: 100}

    """
    def create(name, price) do
      {:ok, %Product{name: name, price: price}}
    end
  end

  defmodule Cart do
    use GenServer

    # Client API

    # Start the GenServer
    def start_link(initial_state \\ %{}) do
      GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
    end

    # Add item to the cart
    def add_item(%Product{} = product) do
      GenServer.call(__MODULE__, {:add, product})
    end

    # Get current cart contents
    def get_contents() do
      GenServer.call(__MODULE__, :get)
    end

    def get_amount() do
      GenServer.call(__MODULE__, :get_amount)
    end

    def update_quantity(id, quant) when is_integer(quant) and quant > 0 do
      GenServer.call(__MODULE__, {:update_quantity, id, quant})
    end

    # Server Callbacks

    def init(initial_state) do
      {:ok, initial_state}
    end

    def handle_call({:add, %Product{id: id} = product}, _from, state) do
      # Add item or increase count
      new_state = Map.update(state, id, {product, 1}, fn {prod, qty} -> {prod, qty + 1} end)
      {:reply, :ok, new_state}
    end

    def handle_call(:get, _from, state) do
      {:reply, state, state}
    end

    def handle_call(:get_amount, _from, state) do
      amount =
        state
        |> Enum.reduce(0.0, fn {_id, {%Product{price: price}, quantity}}, acc ->
          acc + price * quantity
        end)

      {:reply, amount, amount}
    end

    def handle_call({:update_quantity, id, quant}, _from, state) do
      new_state =
        case Map.get(state, id) do
          {product, old_quantity} ->
            Map.put(state, id, {product, quant + old_quantity})

          # If the product doesn't exist, maintain the existing state
          nil ->
            state
        end

      {:reply, :ok, new_state}
    end
  end
end
