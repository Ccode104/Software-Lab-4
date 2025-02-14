# Assignment 2: Publish-Subscribe (Kafka)

## Objective
Learn how to implement a publish-subscribe pattern using Apache Kafka.
Here, we create a topic, have 1 producer and 2 consumers.

## Tasks

### 1. Create a Kafka Topic
- Set up Kafka on your system.(Start Zookeeper and Kafka broker - Refer Assignment 1). 
- Create a topic named `updates`.
  ```sh
  .\bin\windows\kafka-topics.bat --create --topic updates --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
  ```

### 2. Write a Producer
- Implement a Kafka producer that sends messages like `Update 1`, `Update 2`, etc.
-  Producer code in Python (using `kafka-python`):
  (Note : Run pip install kafka-python in cmd to install the library.)

  ```python
  from kafka import KafkaProducer
  import time

  producer = KafkaProducer(bootstrap_servers='localhost:9092')
  topic = 'updates'

  for i in range(1, 6):
      message = f"Update {i}"
      producer.send(topic, message.encode('utf-8'))
      print(f"Produced: {message}")
      time.sleep(1)

  producer.close()
  ```

### 3. Create Consumers
- **Consumer 1**: Prints messages in uppercase.
- **Consumer 2**: Prints messages in lowercase.

#### Consumer 1 (Uppercase)
```python
from kafka import KafkaConsumer

consumer = KafkaConsumer('updates', bootstrap_servers='localhost:9092', auto_offset_reset='earliest')
for message in consumer:
    print(f"Consumer 1 (Uppercase): {message.value.decode('utf-8').upper()}")
```

#### Consumer 2 (Lowercase)
```python
from kafka import KafkaConsumer

consumer = KafkaConsumer('updates', bootstrap_servers='localhost:9092', auto_offset_reset='earliest')
for message in consumer:
    print(f"Consumer 2 (Lowercase): {message.value.decode('utf-8').lower()}")
```

### 4. Run the Producer and Consumers Simultaneously
- Open three terminals.
- Start **Consumer 1** in the first terminal.
- Start **Consumer 2** in the second terminal.
- Start the **Producer** in the third terminal.

### 5. Images
![Uppercase - Consumer 1](./images/Consumer%201%20Output.png)
![Lowercase - Consumer 2](./images/Consumer%202%20Output.png)
![Producer Input](./images/Producer%20Input.png)
## Conclusion
This assignment helps in understanding the Kafka publish-subscribe pattern, where a producer sends messages to a topic, and multiple consumers receive and process the messages independently.

