from kafka import KafkaConsumer
import json

consumer = KafkaConsumer(
    'metrics',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)

for message in consumer:
    print(f"[METRIC] {message.value}")