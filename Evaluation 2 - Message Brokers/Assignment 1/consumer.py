from kafka import KafkaConsumer

consumer = KafkaConsumer(
    'hello_topic',
    bootstrap_servers='localhost:9092',
    auto_offset_reset='earliest',
    enable_auto_commit=True,
    group_id='hello_group'
)

print("Consumer Started...")

for message in consumer:
    print(f"Received: {message.value.decode('utf-8')}")