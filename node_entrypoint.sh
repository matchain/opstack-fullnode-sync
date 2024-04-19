until nc -z -w 5 geth 8551; do
    echo "Waiting for geth ..."
    sleep 5
done
echo "geth is up"

if [ ! -f "/data/rollup.json" ]; then
    wget -O /data/rollup.json $ROLLUP_CONFIG_URL
    echo "Generating p2p keypair"
    op-node --p2p.genkey=/data/opnode_p2p_priv.txt
fi

# p2p.discovery.path
mkdir -p /data/opnode_discovery_db
mkdir -p /data/opnode_peerstore_db

op-node \
    --syncmode=execution-layer \
    --l1=$L1_RPC \
    --l1.rpckind=$L1_RPC_KIND \
    --l1.trustrpc \
    --l1.beacon.ignore \
    --l2=http://geth:8551 \
    --l2.jwt-secret=/jwt.txt \
    --rollup.config=/rollup.json \
    --metrics.enabled \
    --p2p.listen.ip=0.0.0.0 \
    --p2p.listen.tcp=9003 \
    --p2p.listen.udp=9003 \
    --p2p.discovery.path=/data/opnode_discovery_db \
    --p2p.peerstore.path=/data/opnode_peerstore_db \
    --p2p.priv.path=/data/opnode_p2p_priv.txt \
    --p2p.static=$P2P_ADDR \
    --plasma.enabled \
    --plasma.verify-on-read \
    --plasma.da-server=$PLASMA_DA_SERVER
