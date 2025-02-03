
# Kafka Message Broker Monitoring and Consumer Scaling Solution

## 1. Enable Monitoring for Kafka

### JMX Metrics Setup

1. **Enable JMX for Kafka Brokers**:
   - Set the environment variable `KAFKA_JMX_OPTS` to enable JMX monitoring:
     ```bash
     export KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false"
     ```
   - Restart Kafka brokers with the JMX option.

2. **Monitor Kafka Using JMX**:
   - Use JConsole, JVisualVM, or Prometheus + Grafana for JMX metrics visualization.
   - Track metrics like message throughput, broker health, and consumer lag.

---

## 2. Simulate a High Volume of Messages from the Producer

1. **Kafka Producer Application**:
   - Write a Kafka producer in Python using the `kafka-python` library or Java using the `org.apache.kafka.clients.producer.KafkaProducer` class.
   
   Example Python code for simulating a high volume of messages:
   ```python
   from kafka import KafkaProducer
   import json
   import time

   producer = KafkaProducer(bootstrap_servers='localhost:9092', value_serializer=lambda v: json.dumps(v).encode('utf-8'))

   topic = 'high-volume-topic'

   for i in range(1000000):  # Sending 1 million messages
       message = {'message_id': i, 'content': f'Message {i}'}
       producer.send(topic, message)
       if i % 1000 == 0:
           print(f'Sent {i} messages')
       time.sleep(0.001)  # Simulating a high volume (1ms delay)
   producer.flush()
   ```

2. **Producer Performance Benchmarking**:
   - You can also use Kafka’s built-in producer performance test tool to benchmark and simulate message loads:
     ```bash
     kafka-producer-perf-test --topic high-volume-topic --num-records 1000000 --record-size 100 --throughput 1000000 --producer-props bootstrap.servers=localhost:9092
     ```

---

## 3. Scale the Number of Consumers Dynamically

1. **Kafka Consumer Application**:
   - Create a consumer in Python using `kafka-python`.

   Python consumer code:
   ```python
   from kafka import KafkaConsumer

   consumer = KafkaConsumer('high-volume-topic', bootstrap_servers='localhost:9092', group_id='test-group')

   for message in consumer:
       print(f"Received message: {message.value}")
   ```

---
## Key Kafka JMX Metrics for Throughput and Latency**

### **A. Broker Metrics**
These measure the performance of the Kafka cluster.

| Metric | Description |
|--------|------------|
| **kafka.server:type=BrokerTopicMetrics,name=BytesInPerSec** | Total bytes received per second (Throughput) |
| **kafka.server:type=BrokerTopicMetrics,name=BytesOutPerSec** | Total bytes sent per second (Throughput) |
| **kafka.network:type=RequestMetrics,name=TotalTimeMs,request=Produce** | Latency for producing messages (Mean, 99th percentile) |
| **kafka.network:type=RequestMetrics,name=TotalTimeMs,request=FetchConsumer** | Latency for fetching messages by consumers (Mean, 99th percentile) |

---

### **B. Producer Metrics**
These measure the performance of producers.

| Metric | Description |
|--------|------------|
| **kafka.producer:type=producer-metrics,client-id=*, name=record-send-rate** | Number of records sent per second (Throughput) |
| **kafka.producer:type=producer-metrics,client-id=*, name=record-queue-time-avg** | Average time a record spends in the queue (Latency) |
| **kafka.producer:type=producer-metrics,client-id=*, name=record-send-total** | Total number of records sent |

---

### **C. Consumer Metrics**
These measure the performance of consumers.

| Metric | Description |
|--------|------------|
| **kafka.consumer:type=consumer-fetch-manager-metrics,client-id=*, name=bytes-consumed-rate** | Number of bytes consumed per second (Throughput) |
| **kafka.consumer:type=consumer-fetch-manager-metrics,client-id=*, name=fetch-latency-avg** | Average time taken to fetch a record (Latency) |

---

## **3. Monitoring JMX Metrics**
### **Using JConsole**
1. Run `jconsole` (Java Monitoring and Management Console).
2. Connect to your Kafka broker’s JMX port (e.g., `9999`).
3. Navigate to `kafka.server`, `kafka.producer`, or `kafka.consumer` to find the relevant metrics.

---

## **4. Understanding Throughput and Latency**
- **High Throughput** (BytesInPerSec, BytesOutPerSec) indicates a well-utilized Kafka cluster.
- **High Latency** (Produce Request Time, Fetch Request Time) suggests slow processing, which may need tuning.


---

## Images
![Metrics](./images/Bytes%20in%20per%20sec.png)
![Metrics](./images/Bytes%20Out%20per%20sec.png)
![Metrics](./images/Consumer%20Latency.png)
![Metrics](./images/Producer%20Latency.png)


