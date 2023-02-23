defmodule ExampleConsumer do
  # function to accept Kafka messaged MUST be named "handle_message"
  # MUST accept arguments structured as shown here
  # MUST return :ok
  # Can do anything else within the function with the incoming message
  # Application.ensure_all_started(:inets)
  # Application.ensure_all_started(:ssl)

  def handle_message(%{key: key, value: value} = message) do

    url = "http://opensearch-node1:9200/harpia-search-2023-02-23_2/_doc"
    headers = [{"content-type", "application/json"}]
    # body = '{"message":"helo world", "@timestamp": "2023-02-23T12:41:16.481880351Z"}'
    {_, body_decoded} = JSON.decode(value)
    {:ok, datetime} = DateTime.now("Etc/UTC")
    body_encoded = Map.put(body_decoded, "@ingestion_timestamp", DateTime.to_iso8601(datetime))
    {sucesso, body} = JSON.encode(body_encoded)
    IO.puts(to_string(body))
    IO.puts(sucesso)




    HTTPoison.start
    HTTPoison.post!(url, body, headers, [])


    :ok
  end
end
