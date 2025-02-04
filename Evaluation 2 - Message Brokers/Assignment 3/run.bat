@echo off
echo Starting Kafka Task Queue setup...

:: Step 3: Create the Kafka Topic (task_queue)
start cmd /k D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic task_queue --bootstrap-server localhost:9092 --partitions 2 --replication-factor 1
timeout /t 5

:: Step 4: Verify the Topic is created
start cmd /k D:\Github\kafka\bin\windows\kafka-topics.bat --list --bootstrap-server localhost:9092
timeout /t 5

echo Kafka setup is ready. Now running the Producer and Consumers.

:: Step 5: Start Worker Consumer 1 in a new window
start cmd /k python consumer.py

:: Step 6: Start Worker Consumer 2 in a new window
start cmd /k python consumer.py

timeout /t 1
:: Step 7: Start Producer (Task Generator) in a new window
start cmd /k python producer.py

echo Producer and Workers are running. Press any key to exit.
pause
exit
