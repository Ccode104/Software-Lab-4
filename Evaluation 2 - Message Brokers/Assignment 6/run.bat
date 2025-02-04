@echo off
setlocal

start cmd /k "D:\Github\Kafka\bin\windows\kafka-topics.bat --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 5 --topic high-volume-topic"
timeout /t 1
:: Define Python scripts to run
set consumer=consumer.py
set producer=producer.py

:: Open each script in a new command prompt window
start cmd /k "python %producer%"
timeout /t 1
start cmd /k "python %consumer%"
start cmd /k "python %consumer%"
start cmd /k "python %consumer%"
start cmd /k "python %consumer%"
start cmd /k "python %consumer%"

endlocal