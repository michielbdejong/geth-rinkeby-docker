# geth-rinkeby-docker
Dockerfile that runs geth ('go-ethereum') as a full node against the current ("rinkeby") testnet for ethereum.
The cache has been lowered from 512 to 128, so this container should run OK on a vps with 2Gb of memory.
You can also edit the CMD line in the Dockerfile, or specify a customized command at runtime.

```sh
docker build --tag michielbdejong/geth-rinkeby .
export PWD=`pwd`
# copy empty Rinkeby database to host for easy reuse:
docker run -v $PWD:/host michielbdejong/geth-rinkeby cp -r .rinkeby /host/rinkeby
# start syncing:
CONTAINER=`docker run -d --net=host -v $PWD/rinkeby:/root/.rinkeby michielbdejong/geth-rinkeby`
docker logs -f $CONTAINER
> ...
> INFO [07-27|12:16:14] Imported new block headers               count=2048 elapsed=2.468s    number=104768 hash=c839e8…e23ba4 ignored=0
> ...
```

This allows you to easily attach to geth from your host machine, as we'll see below.
Once the 'number' is in those logs is equal to the current 'Best Block' on https://www.rinkeby.io/, your node is in sync with the Rinkeby network. You can then generate your wallet:

```sh
pwgen 40 1
> xidaequeequuu4xah8Ohnoo1Aesumiech6tiay1h
docker run -it --net=host michielbdejong/geth-rinkeby geth attach http://localhost:8545
> personal.newAccount('xidaequeequuu4xah8Ohnoo1Aesumiech6tiay1h')
"0x596144741ac842bf4c5f976d01e5ca0e8b552963"
```

Now go to 'Block Explorer' on https://www.rinkeby.io/ and in the box at the top, search Rinkeby (clique) testnet for your newly created wallet (0x596144741ac842bf4c5f976d01e5ca0e8b552963 without quotes).
Once it shows up, create a gist on https:gist.github.com, containing just that string, and paste the gist URL into the 'Crypto Faucet' page of https://www.rinkeby.io/.
It should say 'Funding request accepted', and a funding transaction of 3 Ether should show op in the 'Block Explorer' page when you search for your wallet again.

If you want to deploy a contract to Rinkeby, be aware that the current instructions in the Ethereum documentation are outdated: `eth.getCompilers()` no longer works.
Instead, paste your solidity code into https://ethereum.github.io/browser-solidity/ and see 'Web3 deploy' in the Contract tab on the right; copy-paste that JavaScript
into your attached geth container. Be sure to check your balance and unlock your account first:

```sh
docker run -it --net=host michielbdejong/geth-rinkeby geth attach http://localhost:8545
> web3.fromWei(eth.getBalance("0x596144741ac842bf4c5f976d01e5ca0e8b552963"), "ether")
3
> personal.unlockAccount("0x596144741ac842bf4c5f976d01e5ca0e8b552963", "xidaequeequuu4xah8Ohnoo1Aesumiech6tiay1h")
true
> [now paste the Web3 deploy code from the online solidity compiler]
true
```
