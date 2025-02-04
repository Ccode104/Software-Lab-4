from kafka import KafkaProducer
import time
import json

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

tasks = ["Task 1: Process file A", "Task 2: Process file B", "Task 3: Process file C","Task 4: Process file A", "Task 5: Process file B", "Task 6: Process file C","Task 7: Process file A", "Task 8: Process file B", "Task 9: Process file C"]

for task in tasks:
    producer.send('task_queue', {'task': task})
    print(f"Produced: {task}")
    time.sleep(1)  # Simulating task production delay

producer.flush()
producer.close()