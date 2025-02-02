# Kafka Task Queue Implementation

## Objective
Implement a task queue to distribute tasks among multiple workers using Apache Kafka.

## Overview
We will simulate a scenario where tasks (e.g., processing files) are distributed among multiple workers. A producer will send task descriptions to a Kafka topic, and multiple worker consumers will pull tasks from the queue, process them, and ensure even distribution of tasks.

## Components
1. **Producer**: Publishes tasks to a Kafka topic.
2. **Workers**: Consume tasks from the Kafka topic and process them.

## Implementation Details

### 1. Kafka Setup(Refer Assignment 1 for initial set-up)

# Create a topic named 'task_queue'
```
kafka-topics.sh --create --topic task_queue --bootstrap-server localhost:9092 --partitions 2 --replication-factor 1
```

### 2. Producer (Task Generator)
The producer will send messages (tasks) to the Kafka topic.

```python
from kafka import KafkaProducer
import time
import json

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

tasks = ["Task 1: Process file A", "Task 2: Process file B", "Task 3: Process file C"]

for task in tasks:
    producer.send('task_queue', {'task': task})
    print(f"Produced: {task}")
    time.sleep(1)  # Simulating task production delay

producer.flush()
producer.close()
```

### 3. Worker Consumers
Workers will pull tasks from the Kafka topic and simulate processing by sleeping for a random duration.

```python
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
    print(f"Worker {random.randint(1, 2)} processing: {task}")
    time.sleep(random.randint(1, 5))  # Simulating processing time
```

### 4. Running Workers
Start multiple workers to ensure tasks are evenly distributed:

```bash
python worker.py  # Run this command in multiple terminals
```

## Expected Behavior
- The producer sends task descriptions to Kafka.
- Kafka distributes messages among multiple workers.
- Workers process tasks by printing the task and sleeping for a random duration.
- Tasks are evenly distributed between workers.
## Images
![Producer](./images/Producer.jpg)
![Worker 1](./images/Worker%201%20Output.jpg)
![Worker 2](./images/Worker%202%20Output.jpg)
## Conclusion
This implementation demonstrates how Kafka can be used for task distribution among multiple workers. The consumer group ensures that tasks are evenly distributed, making the system scalable and efficient.

