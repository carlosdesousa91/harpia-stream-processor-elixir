defmodule ExampleProducer do
  def send_my_message({key, value}, topic) do
    IO.puts("ExampleProducer called")
    Kaffe.Producer.produce_sync(topic, [{key, value}])
  end

  def send_my_message(key, value) do
    IO.puts("ExampleProducer called")
    Kaffe.Producer.produce_sync(key, value)
  end

  def send_my_message(value) do
    IO.puts("ExampleProducer called")
    Kaffe.Producer.produce_sync("sample_key", value)
  end
end
