start cmd /k "D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic alerts --bootstrap-server localhost:9092"
start cmd /k "D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic logs --bootstrap-server localhost:9092"
start cmd /k "D:\Github\kafka\bin\windows\kafka-topics.bat --create --topic metrics --bootstrap-server localhost:9092"

timeout /t 1
start cmd /k "python consumer - alert.py"
start cmd /k "python consumer - logs.py"
start cmd /k "python consumer - metrics.py"

timeout /t 1
start cmd /k "python producer.py"

