# Set common environment variables
export FABRIC_CFG_PATH=${PWD}/config

# Function to join a channel and list it
join_channel() {
  local peer_id=$1
  local tls_rootcert=$2
  local mspconfigpath=$3
  local address=$4

  export CORE_PEER_ID="$peer_id"
  export CORE_PEER_LOCALMSPID="$peer_id"
  export CORE_PEER_TLS_ENABLED=true
  export CORE_PEER_TLS_ROOTCERT_FILE="$tls_rootcert"
  export CORE_PEER_MSPCONFIGPATH="$mspconfigpath"
  export CORE_PEER_ADDRESS="$address"

  # Set gossip-related environment variables
  export CORE_PEER_GOSSIP_PULLINTERVAL=2s
  export CORE_PEER_GOSSIP_RECONNECTINTERVAL=15s
  export CORE_PEER_GOSSIP_RECVBUFFSIZE=40
  export CORE_PEER_GOSSIP_SENDBUFFSIZE=400

  # Join channel and list channels
  peer channel join -b ./artifacts/mychannel.block
  peer channel list
}

# Org1 Peer0
join_channel "Org1MSP" "${PWD}/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" "localhost:7061"

# Org1 Peer1
join_channel "Org1MSP" "${PWD}/crypto-config/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" "localhost:8054"

# Org2 Peer0
join_channel "Org2MSP" "${PWD}/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" "localhost:8061"

# Org2 Peer1
join_channel "Org2MSP" "${PWD}/crypto-config/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt" "${PWD}/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" "localhost:7055"
