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