defmodule ExampleConsumer do
  # function to accept Kafka messaged MUST be named "handle_message"
  # MUST accept arguments structured as shown here
  # MUST return :ok
  # Can do anything else within the function with the incoming message

  def handle_messages(messages) do
    for %{key: key, value: value} = message <- messages do
      # IO.inspect(message)
      # IO.puts("ExampleConsumer called")
      IO.puts("#{key}: #{value}")
    end
    :ok
  end
end
