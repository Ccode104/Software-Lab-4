@echo off
echo Starting Apache Kafka setup...

:: Step 1: Create Kafka Topic
:: D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic hello_topic --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1

:: Step 2: Verify Topic List
:: D:\Github\kafka\bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092

echo Kafka setup is ready.

:: Step 4: Start Kafka Producer
start cmd /k "python producer.py"

:: Step 3: Start Kafka Consumer
start cmd /k "python consumer.py"


echo Kafka Producer and Consumer started.
pause
