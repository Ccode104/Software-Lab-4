# Assignment 1: Introduction to Kafka

## Objective
Understand the basics of message brokers and set up Kafka.

## Tasks

### **1. Install Kafka on Your Local Machine**
Ensure Kafka is installed and running. If not, download and install Apache Kafka from [here](https://kafka.apache.org/downloads).

#### **Start Zookeeper**
```bash
bin/zookeeper-server-start.sh config/zookeeper.properties
```

#### **Start Kafka Broker**
```bash
bin/kafka-server-start.sh config/server.properties
```

#### **Create Kafka Topic**
```bash
bin/kafka-topics.sh --create --topic hello_topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
```

#### **Verify the Topic**
```bash
bin/kafka-topics.sh --list --bootstrap-server localhost:9092
```

---

### **2. Kafka Producer (Sends "Hello, World!" Message)**
Create a file `producer.py`:

```python
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
```

---

### **3. Kafka Consumer (Receives and Prints the Message)**
Create a file `consumer.py`:

```python
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
```

---

### **4. Running Everything Simultaneously**

### **Start Consumer**
```bash
python consumer.py
```

### **Start Producer**
```bash
python producer.py
```

---

### **5.Images**

#### **Producer Input**
![Received the message : Hello World!](./images/Producer%20Input.png)

#### **Consumer Output:**
![Received the message : Hello World!](./images/Consumer%20Output.png)

---

Now your Kafka producer and consumer are fully functional! 🚀

