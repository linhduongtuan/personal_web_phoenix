defmodule PersonalWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PersonalWebWeb.Telemetry,
      PersonalWeb.Repo,
      {DNSCluster, query: Application.get_env(:personal_web, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PersonalWeb.PubSub},
      # Start a worker by calling: PersonalWeb.Worker.start_link(arg)
      # {PersonalWeb.Worker, arg},
      # Start to serve requests, typically the last entry
      PersonalWebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PersonalWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PersonalWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
