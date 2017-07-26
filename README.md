# geth-rinkeby-docker
Dockerfile that runs geth ('go-ethereum') as a light node against the current ("rinkeby") testnet for ethereum.

```sh
docker build --tag michielbdejong/geth-rinkeby .
export PWD=`pwd`
export CONTAINER=`docker run -d --net=host -v $PWD/blocks:/root/.rinkeby michielbdejong/geth-rinkeby`
docker logs -f $CONTAINER
```

This will expose ports 8545 and 30303 publically on your server, so in production you probably want to omit the `--net=host`.
It does however allow you to easily attach to geth:
```sh
docker run -it --net=host michielbdejong/geth-rinkeby geth attach http://localhost:8545
```
