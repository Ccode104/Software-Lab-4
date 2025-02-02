# Assignment 1: Introduction to Kafka

## Objective
Understand the basics of message brokers and set up Kafka.

## Tasks

### **1. Install Kafka on Your Local Machine**
Download and install Apache Kafka from [here](https://kafka.apache.org/downloads).
Extract the zip file.

Here are some important edits to be made (for Windows) :
<ol>
    <li>Go to the config folder in extracted folder</li>
    <li>Edit the server.properties file: put the path of your extracted folder in the logs.dir = \tmp\kafka-logs</li>
    <li>Do the same for zookeeper.properties for data.dir = \tmp\zookeeper-data</li>
</ol>

#### **Start Zookeeper**
```bash
.\bin\windows\zookeeper-server-start.bat config\zookeeper.properties
```

#### **Start Kafka Broker**
```bash
.\bin\windows\kafka-server-start.bat config\server.properties
```

#### **Create Kafka Topic**
```bash
.\bin\windows\kafka-topics.bat --create --topic hello_topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
```

#### **Verify the Topic**
```bash
.\bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092
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

### **5. Expected Output**

#### **Consumer Output:**
```
Received: Hello, World!
```

---


