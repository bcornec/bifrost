#!/bin/bash

# Build and tag images
docker build -t "bifrost" .
docker tag bifrost:latest localhost:5000/bifrost
