#!/bin/bash

MINECRAFT_VERSION=$(cat BuildData/info.json | grep minecraftVersion | cut -d '"' -f 4)
VANILLA_JAR=work/$MINECRAFT_VERSION/$MINECRAFT_VERSION.jar

VANILLA_URL="https://s3.amazonaws.com/Minecraft.Download/versions/$MINECRAFT_VERSION/minecraft_server.$MINECRAFT_VERSION.jar"

SERVER_JAR=IonSpigot-Server/target/$(ls IonSpigot-Server/target | grep -P "^server-[\d\.]+-[\w\.]+(-SNAPSHOT)?.jar")

if [ ! -f "$SERVER_JAR" ]; then
    echo "Server Jar: $SERVER_JAR not found"
    exit 1;
fi;

./generateJar.sh "$SERVER_JAR" "$VANILLA_JAR" "$VANILLA_URL" "Ion"

if [ $? != 0 ]; then
    echo "Failed to generate jar"
    exit 1
fi;

mkdir -p build

cp work/Paperclip/Ion.jar build/Ion.jar
