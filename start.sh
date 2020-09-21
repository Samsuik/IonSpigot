#!/bin/bash

basedir=`pwd`

if [[ $# -lt 1 ]]; then
    echo "Usage ./start.sh {server directory}"
    exit 1;
fi;

# This is for testing purposes, I don't expect anyone else to use this
DIR=$1
JAR="$basedir/IonSpigot-Server/target/server-1.8.8-R0.2-SNAPSHOT.jar"

cd "$DIR"
java -jar "$JAR"