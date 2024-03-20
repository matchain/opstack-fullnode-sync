# do geth init if datadir is empty
if [ -z "$(ls -A /db)" ]; then
    echo "Initializing geth datadir"
    geth init --datadir=/db /genesis.json
else
    echo "geth datadir is not empty, skipping initialization"
fi

geth \
    --verbosity=3 \
    --datadir=/db \
    --rollup.disabletxpoolgossip=false \
    --rollup.sequencerhttp=$SEQUENCER_HTTP \
    --http \
    --http.addr=0.0.0.0 \
    --http.api=web3,debug,eth,txpool,net,engine \
    --ws \
    --ws.addr=0.0.0.0 \
    --ws.api=web3,debug,eth,txpool,net,engine \
    --authrpc.addr=0.0.0.0 \
    --authrpc.port=8551 \
    --authrpc.jwtsecret=/jwt.txt \
    --bootnodes=$BOOTNODES \
    --metrics
