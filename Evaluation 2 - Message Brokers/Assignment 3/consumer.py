from kafka import KafkaConsumer
import json
import time
import random

consumer = KafkaConsumer(
    'task_queue',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda m: json.loads(m.decode('utf-8')),
    group_id='worker_group',
    auto_offset_reset='earliest'
)

for message in consumer:
    task = message.value['task']
    print(f"Worker processing: {task}")
    time.sleep(1)  # Simulating processing time