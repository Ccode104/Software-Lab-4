#!/bin/bash

# IoT Sensor Simulator using Hyperledger Fabric CLI

CHANNEL_NAME="mychannel"
CC_NAME="iot_chaincode"
ORG="org1"

# Function to generate random sensor data
generate_sensor_data() {
    SENSOR_ID="sensor-123"
    TEMP=$(awk -v min=20 -v max=30 'BEGIN{srand(); print min+rand()*(max-min)}')
    HUMIDITY=$(awk -v min=30 -v max=50 'BEGIN{srand(); print min+rand()*(max-min)}')
    echo "$SENSOR_ID $TEMP $HUMIDITY"
}

# Infinite loop to simulate sensor readings
while true; do
    read SENSOR_ID TEMP HUMIDITY <<< $(generate_sensor_data)
    echo "Submitting transaction: Sensor=$SENSOR_ID, Temp=$TEMP, Humidity=$HUMIDITY"
    
    # Invoke the chaincode using Fabric CLI
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls --cafile "$ORDERER_CA" \
        -C "$CHANNEL_NAME" -n "$CC_NAME" \
        --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG1_CA" \
        -c '{"Args":["writeSensorData", "'$SENSOR_ID'", "'$TEMP'", "'$HUMIDITY'"]}'
    
    sleep 5 # Wait for 5 seconds before sending the next data

done
