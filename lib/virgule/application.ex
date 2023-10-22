defmodule Virgule.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Virgule.Repo,
      {Plug.Cowboy, scheme: :http, plug: Virgule.Router, options: [port: 4000]}
    ]

    opts = [strategy: :one_for_one, name: Virgule.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
