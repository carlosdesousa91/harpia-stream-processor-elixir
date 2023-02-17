defmodule ElixirKaffeCodealong.Application do
  use Application # read more about Elixir's Application module here: https://hexdocs.pm/elixir/Application.html

  def start(_type, _args) do
    # import Supervisor.Spec
    children = [
      # worker(Kaffe.Consumer, []) # calls to start Kaffe's Consumer module
      %{
        id: Kaffe.GroupMemberSupervisor,
        start: {Kaffe.GroupMemberSupervisor, :start_link, []},
        type: :supervisor
      }
    ]
    opts = [strategy: :one_for_one, name: ExampleConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
