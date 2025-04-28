#!/bin/bash

# To be used on app machine

nc 192.168.100.10 1234 < file
[root@app 02]# cat server.sh
i=0
mkdir -p "received_files"
while true; do
    nc -l 1234 > "received_files/file$i"
    if [ -s "received_files/file$i" ]; then
        let i++
done
if [ ! -s "received_files/file$i" ]; then
    rm "received_files/file$i"
fi