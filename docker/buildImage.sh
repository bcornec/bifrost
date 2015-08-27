#!/bin/bash

# Build and tag images
# Build and tag images
docker rmi bifrost
docker build -t "bifrost" .
if [ $? -eq 0 ]; then
	docker tag -f bifrost:latest localhost:5000/bifrost
fi
