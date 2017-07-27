FROM ubuntu
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y ethereum wget git vim
RUN wget https://www.rinkeby.io/rinkeby.json
RUN geth --datadir=$HOME/.rinkeby init rinkeby.json
EXPOSE 8545
EXPOSE 30303
EXPOSE 30303/udp
# To run a rinkeby archive node:
#CMD geth --networkid=4 --datadir=$HOME/.rinkeby --cache=1024 --syncmode=full --ethstats='yournode:Respect my authoritah!@stats.rinkeby.io' --bootnodes=enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304 --rpc --rpcapi="personal,eth,network" --rpcaddr "0.0.0.0"

# To run a rinkeby full node:
#CMD geth --networkid=4 --datadir=$HOME/.rinkeby --cache=512 --ethstats='yournode:Respect my authoritah!@stats.rinkeby.io' --bootnodes=enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304 --rpc --rpcapi="personal,eth,network" --rpcaddr "0.0.0.0"

# To run a rinkeby light node:
CMD geth --networkid=4 --datadir=$HOME/.rinkeby --syncmode=light --ethstats='yournode:Respect my authoritah!@stats.rinkeby.io' --bootnodes=enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304 --rpc --rpcapi="personal,eth,network" --rpcaddr "0.0.0.0"

# To run a rinkeby embedded node (experimental):
# CMD geth --networkid=4 --datadir=$HOME/.rinkeby --cache=32 --syncmode=light --ethstats='yournode:Respect my authoritah!@stats.rinkeby.io' --bootnodes=enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303?discport=30304 --rpc --rpcapi="personal,eth,network" --rpcaddr "0.0.0.0"
