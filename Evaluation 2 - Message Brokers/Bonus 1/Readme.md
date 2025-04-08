Objective : To handle failed message processing using dead letter queues in Kafka.

### 1. Create a Kafka Topic for Processing Tasks

```bash
kafka-topics.sh --create --topic task-processing --bootstrap-server <broker-list> --partitions 3 --replication-factor 1
```

This will create a topic named `task-processing` with 3 partitions and a replication factor of 1.

### 2. Simulate Message Failure and Set Up Retry Mechanism
Configure your consumer to process messages and move failed messages to a "dead letter" queue (DLQ) after 3 failed attempts.

- **Consumer Logic:**
    - Try processing the message.
    - If processing fails, retry up to 3 times.
    - After 3 failures, send the message to a dead letter queue (DLQ) topic.
  
#### Main Code

```python
from kafka import KafkaConsumer, KafkaProducer
import time

consumer = KafkaConsumer('task-processing', bootstrap_servers='<broker-list>')
producer = KafkaProducer(bootstrap_servers='<broker-list>')

dead_letter_topic = 'dead-letter-task-processing'

def process_message(message):
    try:
        # Simulate message processing (throw exception on failure)
        if message.value == b'fail':
            raise Exception('Processing failed')
        print(f"Processed message: {message.value}")
        return True
    except Exception as e:
        print(f"Error: {e}")
        return False

for message in consumer:
    retries = 0
    success = False
    while retries < 3 and not success:
        success = process_message(message)
        if not success:
            retries += 1
            time.sleep(1)  # Delay before retry

    if not success:
        # Move the message to the dead letter topic after 3 failed attempts
        producer.send(dead_letter_topic, message.value)
        print(f"Message sent to dead letter topic: {message.value}")
```

This consumer tries to process each message and moves it to the `dead-letter-task-processing` topic after 3 failures.

### 3. Process Dead Letter Queue Messages and Log Them


```python
consumer_dlq = KafkaConsumer(dead_letter_topic, bootstrap_servers='<broker-list>')

for message in consumer_dlq:
    with open('dead_letter_log.txt', 'a') as log_file:
        log_file.write(f"Failed message: {message.value.decode('utf-8')}\n")
    print(f"Logged message: {message.value.decode('utf-8')}")
```

This script will consume messages from the `dead-letter-task-processing` topic and write them to a log file (`dead_letter_log.txt`) for further analysis.
