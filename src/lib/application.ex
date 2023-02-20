defmodule ElixirKaffeCodealong.Application do
  use Application # read more about Elixir's Application module here: https://hexdocs.pm/elixir/Application.html

  def start(_type, _args) do
    # Send these messages to ensure the topic exist
    ExampleProducer.send_my_message({"test", "Test Message"}, "our_topic")
    ExampleProducer.send_my_message({"test", "Test Message"}, "another_topic")

    children = [
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
