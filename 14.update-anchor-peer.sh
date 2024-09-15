# Set common environment variables
export FABRIC_CFG_PATH=${PWD}/config

# Function to update channel with anchor peers
update_channel() {
  local peer_id=$1
  local tls_rootcert=$2
  local mspconfigpath=$3
  local address=$4
  local anchor_tx_file=$5

  export CORE_PEER_ID="$peer_id"
  export CORE_PEER_LOCALMSPID="$peer_id"
  export CORE_PEER_TLS_ENABLED=true
  export CORE_PEER_TLS_ROOTCERT_FILE="$tls_rootcert"
  export CORE_PEER_MSPCONFIGPATH="$mspconfigpath"
  export CORE_PEER_ADDRESS="$address"

  # Update channel with anchor peer configuration
  peer channel update -o localhost:7050 \
                      --ordererTLSHostnameOverride orderer.example.com \
                      -c mychannel -f "$anchor_tx_file" \
                      --tls --cafile ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
}

# Org1 Peer0
update_channel "Org1MSP" "${PWD}/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" "localhost:7061" "./artifacts/Org1Anchor.tx"

# Org2 Peer0
update_channel "Org2MSP" "${PWD}/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" "localhost:8061" "./artifacts/Org2Anchor.tx"
