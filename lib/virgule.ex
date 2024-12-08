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

    # Server Callbacks

    def init(initial_state) do
      {:ok, initial_state}
    end

    def handle_call({:add, %Product{} = product}, _from, state) do
      # Add item or increase count
      new_state = Map.update(state, product.id, [product], &[product | &1])
      {:reply, :ok, new_state}
    end

    def handle_call(:get, _from, state) do
      {:reply, state, state}
    end

    def handle_call(:get_amount, _from, state) do
      amount =
        state
        |> Enum.flat_map(fn {_id, products} -> products end)
        |> Enum.reduce(0.0, fn %Product{price: price}, acc -> acc + price end)

      {:reply, amount, amount}
    end
  end
end
