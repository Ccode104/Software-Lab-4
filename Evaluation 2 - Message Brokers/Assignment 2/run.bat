@echo off
echo Starting Kafka setup and running Producer/Consumers...

:: Step 3: Create Kafka Topic
start cmd /k D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic updates --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
timeout /t 5

:: Step 4: Verify Topic List
start cmd /k D:\Github\kafka\bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092
timeout /t 5

echo Kafka setup is ready. Now running the Producer and Consumers.

:: Step 5: Start Kafka Consumer 1 (Uppercase)
start cmd /k python consumer1.py
timeout /t 5

:: Step 6: Start Kafka Consumer 2 (Lowercase)
start cmd /k python consumer2.py
timeout /t 5

:: Step 7: Start Kafka Producer
start cmd /k python producer.py

echo Producer and Consumers are running. Press any key to exit.
pause
