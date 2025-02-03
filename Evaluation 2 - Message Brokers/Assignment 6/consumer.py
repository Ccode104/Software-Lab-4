from kafka import KafkaConsumer

consumer = KafkaConsumer('high-volume-topic', bootstrap_servers='localhost:9092', group_id='test-group')

for message in consumer:
   print(f"Received message: {message.value}")