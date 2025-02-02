# Kafka Message Prioritization and Filtering

## Objective
Implement message prioritization and filtering in Kafka by creating different topics, a producer to send messages, and consumers that subscribe selectively.

## Prerequisites
- Install Apache Kafka and Zookeeper
- Set up Kafka broker
- Install required dependencies (e.g., `kafka-python` for Python implementation)

These were done in the Assignment 1 and 2.

## Step 1: Create Kafka Topics

Set up kafka - Refer to Assignment 1

# Create topics
.\bin\windows\kafka-topics.bat --create --topic alerts --bootstrap-server localhost:9092
.\bin\windows\kafka-topics.bat --create --topic logs --bootstrap-server localhost:9092
.\bin\windows\kafka-topics.bat --create --topic metrics --bootstrap-server localhost:9092
```

## Step 1: Implement Kafka Producer
Create a Python script to send messages to different topics.
```python
from kafka import KafkaProducer
import json

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

def send_message(topic, message):
    producer.send(topic, message)
    producer.flush()

# Messages used (They can be anything)
send_message('alerts', {'level': 'high', 'msg': 'CPU usage 90%'})
send_message('logs', {'source': 'app', 'msg': 'User login successful'})
send_message('metrics', {'cpu': 75, 'memory': 60})

print("Messages sent successfully!")
```

## Step 2: Implement Kafka Consumers
Create consumers that subscribe to specific topics.

### Consumer for Alerts
```python
from kafka import KafkaConsumer
import json

consumer = KafkaConsumer(
    'alerts',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)

for message in consumer:
    print(f"[ALERT] {message.value}")
```

### Consumer for Logs
```python
consumer = KafkaConsumer(
    'logs',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)

for message in consumer:
    print(f"[LOG] {message.value}")
```

### Consumer for Metrics
```python
consumer = KafkaConsumer(
    'metrics',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)

for message in consumer:
    print(f"[METRIC] {message.value}")
```

## Step 3: Running the Setup
1. Start Zookeeper and Kafka.
2. Run the producer script to send messages.
3. Start the respective consumers to receive filtered messages.

# Images
![Alert](./images/Consumer%20for%20Alert%20Topic.png)
![Logs](./images/Consumer%20for%20Logs%20Topic.png)
![Metric](./images/Consumer%20for%20Metrics%20Topic.png)
![Producer Success](./images/Producer%20Success.png)
## Conclusion
This setup demonstrates how to implement topic-based message filtering in Kafka. Consumers receive only messages relevant to their subscribed topics, ensuring efficient message processing and prioritization.
