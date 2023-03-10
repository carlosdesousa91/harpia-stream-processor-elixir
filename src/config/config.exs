use Mix.Config

config :kaffe,
  producer: [
    endpoints: [kafka: 9092],
    # endpoints references [hostname: port]. Kafka is configured to run on port 9092.
    # In this example, the hostname is localhost because we've started the Kafka server
    # straight from our machine. However, if the server is dockerized, the hostname will
    # be called whatever is specified by that container (usually "kafka")
    topics: ["our_topic", "another_topic"], # add a list of topics you plan to produce messages to
  ]

config :kaffe,
  consumer: [
    endpoints: [kafka: 9092],
    topics: ["our_topic", "another_topic"],     # the topic(s) that will be consumed
    consumer_group: "example-consumer-group",   # the consumer group for tracking offsets in Kafka
    message_handler: ExampleConsumer,           # the module that will process messages
    offset_reset_policy: :reset_to_latest,
    max_bytes: 50_000_000,                      # 50MB
    worker_allocation_strategy: :worker_per_partition,
  ]
