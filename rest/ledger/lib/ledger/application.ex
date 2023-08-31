defmodule Ledger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    topologies = Application.get_env(:libcluster, :topologies)

    children = [
      # Start the Telemetry supervisor
      LedgerWeb.Telemetry,
      # Start cacje
      Ledger.Cache,
      # Start the Ecto repository
      Ledger.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ledger.PubSub},
      # Start Finch
      {Finch, name: Ledger.Finch},
      # Start the Endpoint (http/https)
      LedgerWeb.Endpoint,
      # Start a worker by calling: Ledger.Worker.start_link(arg)
      # {Ledger.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: Ledger.ClusterSupervisor]]},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ledger.Supervisor]

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LedgerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
