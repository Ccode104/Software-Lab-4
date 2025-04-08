sudo systemctl start docker

# Navigate to the test network directory
echo "Changing directory to ~/a5/fabric-samples/test-network"
cd ~/a5/fabric-samples/test-network

# Bring down the network if it's already running
echo "Executing: ./network.sh down"
./network.sh down

# Bring up the network and create a channel
echo "Executing: ./network.sh up createChannel"
./network.sh up createChannel

# Navigate to the custom chaincode directory
echo "Changing directory to ~/a5/fabric-samples/iot_chaincode"
cd ~/a5/fabric-samples/iot_chaincode

# Enable Go modules and vendor dependencies
echo "Executing: GO111MODULE=on go mod vendor"
GO111MODULE=on go mod vendor

# Return to the test network directory
echo "Changing directory to ../test-network"
cd ../test-network

# Set up environment variables
echo "Setting PATH and FABRIC_CFG_PATH"
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../config/

# Verify peer binary version
echo "Executing: peer version"
peer version

# Package the chaincode
echo "Executing: peer lifecycle chaincode package iot_chaincode.tar.gz"
peer lifecycle chaincode package iot_chaincode.tar.gz --path ../iot_chaincode/ --lang golang --label iot_chaincode_1.0

# Set peer environment for Org1
echo "Setting environment variables for Org1"
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_TLS_ROOTCERT_FILE=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

# Install chaincode for Org1
echo "Executing: peer lifecycle chaincode install iot_chaincode.tar.gz"
peer lifecycle chaincode install iot_chaincode.tar.gz

# Set peer environment for Org2
echo "Setting environment variables for Org2"
export CORE_PEER_LOCALMSPID=Org2MSP
export CORE_PEER_TLS_ROOTCERT_FILE=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051

# Install chaincode for Org2
echo "Executing: peer lifecycle chaincode install iot_chaincode.tar.gz"
peer lifecycle chaincode install iot_chaincode.tar.gz

# Query installed chaincodes
echo "Executing: peer lifecycle chaincode queryinstalled"
peer lifecycle chaincode queryinstalled

# Extract chaincode package ID
echo "Extracting chaincode package ID"
export CC_PACKAGE_ID=$(peer lifecycle chaincode queryinstalled | grep "iot_chaincode_1.0" | awk '{print $3}' | sed 's/,//')

# Approve chaincode for Org1
echo "Executing: peer lifecycle chaincode approveformyorg for Org1"
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name iot_chaincode --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

# Reset environment variables for Org1
echo "Resetting environment variables for Org1"
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:7051

# Approve chaincode for Org1 again
echo "Executing: peer lifecycle chaincode approveformyorg for Org1 again"
peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name iot_chaincode --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

# Check commit readiness
echo "Executing: peer lifecycle chaincode checkcommitreadiness"
peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name iot_chaincode --version 1.0 --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --output json

echo $PWD
# Commit the chaincode
echo "Executing: peer lifecycle chaincode commit"
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name iot_chaincode --version 1.0 --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt"

# Query committed chaincode
echo "Executing: peer lifecycle chaincode querycommitted"
peer lifecycle chaincode querycommitted --channelID mychannel --name iot_chaincode

# Invoke the chaincode to initialize the ledger
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp
# peer chaincode invoke -o localhost:7050 --tls --cafile $ORDERER_CA -C mychannel -n iot_chaincode -c '{"function":"StoreSensorData","Args":["sensor1", "25.5", "60"]}'
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n iot_chaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"StoreSensorData","Args":["sensor1", "25.5", "60"]}'

sleep 5

# Query the chaincode
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_MSPCONFIGPATH=~/a5/fabric-samples/test-network/organizations/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp
peer chaincode query -C mychannel -n iot_chaincode -c '{"function":"QuerySensorData","Args":["sensor1"]}'

# Ensure the last command's output appears
echo "Chaincode query completed."
