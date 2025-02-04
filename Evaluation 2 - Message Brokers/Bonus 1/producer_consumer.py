from kafka import KafkaConsumer, KafkaProducer
import time

consumer = KafkaConsumer('task-processing', bootstrap_servers='localhost:9092')
producer = KafkaProducer(bootstrap_servers='localhost:9092')

dead_letter_topic = 'dead-letter-task-processing'

def process_message(message):
    try:
        # Simulate message processing (throw exception on failure)
        if message.value == b'fail':
            raise Exception('Processing failed')
        print(f"Processed message: {message.value}")
        return True
    except Exception as e:
        print(f"Error: {e}")
        return False

for message in consumer:
    retries = 0
    success = False
    while retries < 3 and not success:
        success = process_message(message)
        if not success:
            retries += 1
            time.sleep(1)  # Delay before retry

    if not success:
        # Move the message to the dead letter topic after 3 failed attempts
        producer.send(dead_letter_topic, message.value)
        print(f"Message sent to dead letter topic: {message.value}")
