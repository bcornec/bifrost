#!/bin/bash

# Build and tag images
# Build and tag images
docker rmi bifrost
docker build -t "bifrost" .
docker tag -f bifrost:latest localhost:5000/bifrost
