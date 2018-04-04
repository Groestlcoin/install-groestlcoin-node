# Установка Bitcoind
* Установить CenOS 7.
* Обновить yum :
```
yum update
```
* Выполнить скрипт установки bitcoind
```
bash install_bitcoind.sh
```
* Создать пользователя для RPC :
```
python ./rpcauth.py alice
String to be appended to bitcoin.conf:
rpcauth=alice:435740d0bcceb2b8e4da42ff8fac7212$a0047757ef940891310ff8973d32123de52401a327aa3e5278ea42ce44fbda4a
Your password:
TRnz8eKyfmi_kYv65lZBaGbhDSu31p7bhfizMyw_IYI=
```
* Скопировать файл конфигурации bitcoin.conf в /root/.bitcoin
* В файл конфигурации вставить строчку для подключения по RPC
```
rpcauth=alice:435740d0bcceb2b8e4da42ff8fac7212$a0047757ef940891310ff8973d32123de52401a327aa3e5278ea42ce44fbda4a
```
* Запустить ноду:
```
bitcoind -daemon
```
* Проверить параметры запущеной ноды:
```
bitcoin-cli -getinfo
```
* Количество загруженых блоков 
```
bitcoin-cli getblockcount
```

