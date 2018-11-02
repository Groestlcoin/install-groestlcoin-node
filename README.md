# Install Groestlcoind
* Installing on CenOS 7.
* Update yum :
```
yum update
```
* Run the installation script
```
bash install_groestlcoind.sh
```
* Create RPC user:
```
python ./rpcauth.py alice
String to be appended to groestlcoin.conf:
rpcauth=alice:435740d0bcceb2b8e4da42ff8fac7212$a0047757ef940891310ff8973d32123de52401a327aa3e5278ea42ce44fbda4a
Your password:
TRnz8eKyfmi_kYv65lZBaGbhDSu31p7bhfizMyw_IYI=
```
* Copy groestlcoin.conf to /root/.groestlcoin
* And add this to groestlcoin.conf
```
rpcauth=alice:435740d0bcceb2b8e4da42ff8fac7212$a0047757ef940891310ff8973d32123de52401a327aa3e5278ea42ce44fbda4a
```
* Start the node:
```
groestlcoind -daemon
```
* Check if the node has started properly:
```
groestlcoin-cli -getinfo
```
* Check synced blocks:
```
groestlcoin-cli getblockcount
```
