# do geth init if datadir is empty
if [ ! -d "/data/geth" ]; then
    echo "Initializing geth datadir"
    wget -O /data/genesis.json $GENESIS_URL
    geth init --datadir=/data /data/genesis.json
else
    echo "geth datadir already initialized, skipping..."
fi

geth \
    --datadir=/data \
    --rollup.disabletxpoolgossip=true \
    --rollup.sequencerhttp=$SEQUENCER_HTTP \
    --http \
    --http.corsdomain="*" \
    --http.vhosts="*" \
    --http.addr=0.0.0.0 \
    --http.api=web3,debug,eth,txpool,net,engine \
    --ws \
    --ws.addr=0.0.0.0 \
    --ws.api=web3,debug,eth,txpool,net,engine \
    --authrpc.addr=0.0.0.0 \
    --authrpc.port=8551 \
    --authrpc.jwtsecret=/jwt.txt \
    --bootnodes=$BOOTNODES \
    --metrics \
    --syncmode=$SYNC_MODE \
    --gcmode=$GC_MODE
