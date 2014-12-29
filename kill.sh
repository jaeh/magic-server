#!/bin/bash

pid=`docker ps | grep jaeh/magic-server | awk '{ print $1; }'`
echo 'killing docker process with pid '$pid
docker kill $pid
