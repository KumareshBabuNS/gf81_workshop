#!/bin/bash

LOCATOR_PORT=10334
SERVER2_PORT=40405
LOCAL_IP=
IP=${LOCAL_IP:=ifconfig | awk '/inet /{print substr($2,1)}' | tail -n1}

. ./setenvironment.sh

gfsh <<!

start locator --name=locator1 --properties-file=config/locator.properties --bind-address=localhost --port=$LOCATOR_PORT --dir=locator --J=-Xms256m --J=-Xmx256m

start server --name=server1 --locators=localhost[$LOCATOR_PORT] --dir=server1 --J=-Xms512m --J=-Xmx512m --classpath=../lib/clientapp.jar::../lib/domain.jar --cache-xml-file=config/cache.xml --properties-file=config/gemfire.properties --J=-Dgemfire.start-dev-rest-api=true --J=-Dgemfire.http-service-bind-address=$IP

start server --name=server2 --locators=localhost[$LOCATOR_PORT] --dir=server2 --J=-Xms512m --J=-Xmx512m --classpath=../lib/clientapp.jar:../lib/domain.jar --cache-xml-file=config/cache.xml  --properties-file=config/gemfire.properties --server-port=$SERVER2_PORT

list members;

list regions;

exit;
!
