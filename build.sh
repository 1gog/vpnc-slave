#!/bin/bash

TAG=0.7.3
docker build -f Dockerfile -t 1gog/vpnc-slave:${TAG} .
docker push 1gog/vpnc-slave:${TAG}
