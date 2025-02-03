from confluent_kafka import Producer

def delivery_report(err, msg):
    if err:
        print(f"Message delivery failed: {err}")
    else:
        print(f"Message delivered to {msg.topic()} [{msg.partition()}]")

producer = Producer({'bootstrap.servers': 'localhost:9092'})

def send_message(chat_room, message):
    producer.produce(chat_room, message.encode('utf-8'), callback=delivery_report)
    producer.flush()

# Example Usage
send_message("chat-room-1", "Hello, Kafka Chat!")