#! /bin/bash

for line in `cat pkg.cfg`;
do
        echo "-----------Install: $line------------------"
        yum install -y $line
done
