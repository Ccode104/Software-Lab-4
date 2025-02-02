from kafka import KafkaProducer

# Create Kafka producer
producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: v.encode('utf-8')  # Convert string to bytes
)

topic_name = "hello_topic"

message = "Hello, World!"
producer.send(topic_name, value=message)
print(f"Sent: {message}")

producer.close()