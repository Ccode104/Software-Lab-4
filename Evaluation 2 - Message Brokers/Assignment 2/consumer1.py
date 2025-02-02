from kafka import KafkaConsumer

consumer = KafkaConsumer('updates', bootstrap_servers='localhost:9092', auto_offset_reset='earliest')
for message in consumer:
    print(f"Consumer 1 (Uppercase): {message.value.decode('utf-8').upper()}")