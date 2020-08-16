createCertificatesForManufacturer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.manufacturer.pharma.com --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-manufacturer.pharma.com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-manufacturer.pharma.com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-manufacturer.pharma.com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-manufacturer.pharma.com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.manufacturer.pharma.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  fabric-ca-client register --caname ca.manufacturer.pharma.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.manufacturer.pharma.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.manufacturer.pharma.com --id.name manufacturerAdmin --id.secret manufactureradminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0manufacturer.pharma.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/msp --csr.hosts peer0.manufacturer.pharma.com --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls --enrollment.profile tls --csr.hosts peer0.manufacturer.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/tlsca/tlsca.manufacturer.pharma.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer0.manufacturer.pharma.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/ca/ca.manufacturer.pharma.com-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/msp --csr.hosts peer1.manufacturer.pharma.com --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls --enrollment.profile tls --csr.hosts peer1.manufacturer.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/peers/peer1.manufacturer.pharma.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users
  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users/User1@manufacturer.pharma.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users/User1@manufacturer.pharma.com/msp --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  mkdir -p crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users/Admin@manufacturer.pharma.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.manufacturer.pharma.com -M ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users/Admin@manufacturer.pharma.com/msp --tls.certfiles ${PWD}/fabric-ca/manufacturer/tls-cert.pem

  cp ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/manufacturer.pharma.com/users/Admin@manufacturer.pharma.com/msp/config.yaml

}

# createcertificatesForManufacturer

createCertificateForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p /crypto-config-ca/peerOrganizations/org2.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.example.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.org2.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo
  echo "Register peer1"
  echo
   
  fabric-ca-client register --caname ca.org2.example.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.org2.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.org2.example.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  mkdir -p crypto-config-ca/peerOrganizations/org2.example.com/peers
  mkdir -p crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp --csr.hosts peer0.org2.example.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls --enrollment.profile tls --csr.hosts peer0.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/tlsca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/tlsca/tlsca.org2.example.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/ca
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/msp/cacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/ca/ca.org2.example.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo
   
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp --csr.hosts peer1.org2.example.com --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls --enrollment.profile tls --csr.hosts peer1.org2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/signcerts/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/keystore/* ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/peers/peer1.org2.example.com/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p crypto-config-ca/peerOrganizations/org2.example.com/users
  mkdir -p crypto-config-ca/peerOrganizations/org2.example.com/users/User1@org2.example.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/users/User1@org2.example.com/msp --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  mkdir -p crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.org2.example.com -M ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp --tls.certfiles ${PWD}/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/msp/config.yaml ${PWD}/crypto-config-ca/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp/config.yaml

}



createCertificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config-ca/ordererOrganizations/pharma.com

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register orderer2"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register orderer3"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register the orderer admin"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/orderers

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/msp --csr.hosts orderer.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls --enrollment.profile tls --csr.hosts orderer.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/signcerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/keystore/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/msp/tlscacerts/tlsca.pharma.com-cert.pem

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/tlscacerts/tlsca.pharma.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/msp --csr.hosts orderer2.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls --enrollment.profile tls --csr.hosts orderer2.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/signcerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/keystore/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer2.pharma.com/msp/tlscacerts/tlsca.pharma.com-cert.pem


  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/example.com/orderers/orderer3.pharma.com/msp --csr.hosts orderer3.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls --enrollment.profile tls --csr.hosts orderer3.pharma.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/ca.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/signcerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/server.crt
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/keystore/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/server.key

  mkdir ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/msp/tlscacerts
  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/tls/tlscacerts/* ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/orderers/orderer3.pharma.com/msp/tlscacerts/tlsca.pharma.com-cert.pem

  # ---------------------------------------------------------------------------

  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/users
  mkdir -p crypto-config-ca/ordererOrganizations/pharma.com/users/Admin@example.com

  echo
  echo "## Generate the admin msp"
  echo
   
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/msp/config.yaml ${PWD}/crypto-config-ca/ordererOrganizations/pharma.com/users/Admin@example.com/msp/config.yaml

}


sudo rm -rf crypto-config-ca/*
#sudo rm -rf fabric-ca/*
createCertificatesForManufacturer
#createCertificateForOrg2
#createCertificateForOrderer

