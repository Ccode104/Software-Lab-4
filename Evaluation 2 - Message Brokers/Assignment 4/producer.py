from kafka import KafkaProducer
import json

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

def send_message(topic, message):
    producer.send(topic, message)
    producer.flush()

# Messages used (They can be anything)
send_message('alerts', {'level': 'high', 'msg': 'CPU usage 90%'})
send_message('logs', {'source': 'app', 'msg': 'User login successful'})
send_message('metrics', {'cpu': 75, 'memory': 60})

print("Messages sent successfully!")