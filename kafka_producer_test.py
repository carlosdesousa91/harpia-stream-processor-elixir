from kafka import KafkaProducer
from kafka.errors import KafkaError
import json
import uuid

def publish_message(
    quantity=100,
    topic="our_topic"
):
    """Publish a new message in Kafka topic."""
    try:
        producer_instance = KafkaProducer(bootstrap_servers=json.loads('["localhost:9093"]'))
        
        for i in range(quantity):
            protocol = {
                "name": f"message {i}",
                "version": 1,
                "flow_id": str(uuid.uuid4()),
                "payload": {
                    "tenant_id": "a99af27d-59d7-49a0-a642-be659fb1a2e3",
                    "field" : "client.nat.port",
                    "field_type": "long",
                    "error_type": "mapper_parsing_exception",
                    "error_reason": "error_reason",
                    "ecs_type": "Object",
                    "status": 1,
                    "tags": {"tags": ["beats","ad"]}
                },
                "metadata": {
                    "type_activity_key": 2
                }
            }
            producer_instance.send(topic, bytes(json.dumps(protocol), "utf-8"))
        
        producer_instance.flush()
        producer_instance.close()

    except KafkaError as error:
        print(f"Exception in publishing message: {error}")

publish_message(quantity=100_000)

# For run in terminal execute: python3 ./tests/kafka_producer_test.py