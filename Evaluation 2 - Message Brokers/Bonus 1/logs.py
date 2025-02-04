from kafka import KafkaConsumer
dead_letter_topic = 'dead-letter-task-processing'

consumer_dlq = KafkaConsumer(dead_letter_topic, bootstrap_servers='localhost:9092')

for message in consumer_dlq:
    with open('dead_letter_log.txt', 'a') as log_file:
        log_file.write(f"Failed message: {message.value.decode('utf-8')}\n")
    print(f"Logged message: {message.value.decode('utf-8')}")
