# geth-rinkeby-heroku
Heroku-compatible app that runs the geth ethereum node against the current ("rinkeby") testnet for ethereum.

```sh
docker build --tag michielbdejong/geth-rinkeby .
docker run -d -p 30303:30303 -v `pwd`/blocks:/root/.ethereum michielbdejong/geth-rinkeby
docker ps
