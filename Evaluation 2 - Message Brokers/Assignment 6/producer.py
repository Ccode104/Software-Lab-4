from kafka import KafkaProducer
import json
import time

producer = KafkaProducer(bootstrap_servers='localhost:9092', value_serializer=lambda v: json.dumps(v).encode('utf-8'))

topic = 'high-volume-topic'

for i in range(10):  # Sending 10
    message = {'message_id': i, 'content': f'Message {i}'}
    producer.send(topic, message)
    print(f'Sent {i} messages')
    time.sleep(1)  # Simulating a high volume (1ms delay)
producer.flush()