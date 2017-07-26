# geth-rinkeby-docker
Dockerfile that runs geth ('go-ethereum') as a light node against the current ("rinkeby") testnet for ethereum.

```sh
docker build --tag michielbdejong/geth-rinkeby .
export PWD=`pwd`
export CONTAINER=`docker run -d --net=host -v $PWD/blocks:/root/.rinkeby michielbdejong/geth-rinkeby`
docker logs -f $CONTAINER
