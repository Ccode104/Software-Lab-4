from confluent_kafka import Consumer

consumer = Consumer({
    'bootstrap.servers': 'localhost:9092',
    'group.id': 'chat-consumers1',
    'auto.offset.reset': 'earliest'
})

chat_room = "chat-room-1"
consumer.subscribe([chat_room])

while True:
    msg = consumer.poll(1.0)
    if msg is None:
        continue
    if msg.error():
        print(f"Consumer error: {msg.error()}")
        continue
    print(f"Received message: {msg.value().decode('utf-8')}")