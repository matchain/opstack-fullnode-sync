until nc -z -w 5 l2 8551; do
    echo "Waiting for local op-l2 ..."
    sleep 3
done
echo "Local op-l2 is up"

# p2p.discovery.path
mkdir -p /data/node/opnode_discovery_db
mkdir -p /data/node/opnode_peerstore_db

op-node \
    --syncmode=execution-layer \
    --l1.trustrpc \
    --l1.beacon.ignore \
    --l2=ws://l2:8551 \
    --l2.jwt-secret=/jwt.txt \
    --rollup.config=rollup.json \
    --rpc.addr=0.0.0.0 \
    --l1=$L1_RPC \
    --l1.rpckind=standard \
    --metrics.enabled=true \
    --p2p.listen.ip=0.0.0.0 \
    --p2p.listen.tcp=9222 \
    --p2p.listen.udp=9222 \
    --p2p.discovery.path=/data/node/opnode_discovery_db \
    --p2p.peerstore.path=/data/node/opnode_peerstore_db \
    --p2p.priv.path=/data/node/opnode_p2p_priv.txt \
    --p2p.static=$P2P_ADDR
