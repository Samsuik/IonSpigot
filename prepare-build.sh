#!/bin/bash

git submodule update --init && ./remap.sh && ./decompile.sh && ./init.sh && ./applyPatches.sh

# Generate paperclip jar in this stage
mkdir -p work/Paperclip
PAPERCLIP_JAR=paperclip.jar
PAPERCLIP_NAME=paperclip-1.0-SNAPSHOT.jar

if [ ! -f work/Paperclip/$PAPERCLIP_JAR ]; then
    if [ ! -d Paperclip ]; then
        echo "Paperclip not found"
        exit 1;
    fi
    echo "Generating Paperclip Jar"
    pushd Paperclip
    mvn -P '!generate' clean install
    if [ ! -f "target/$PAPERCLIP_NAME" ]; then
        echo "Couldn't generate paperclip jar"
        exit;
    fi;
    popd
    cp Paperclip/target/$PAPERCLIP_NAME work/Paperclip/$PAPERCLIP_JAR
fi;
