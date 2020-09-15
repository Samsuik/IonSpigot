#!/bin/bash

# Check if the jar has been built before
if [ ! -d "IdkSpigot-Server/target" ]; then
	./prepare-build.sh
else
	# It has, so we only need to apply patches
	./applyPatches.sh
fi

mvn clean install && ./package.sh
