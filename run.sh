#!/bin/bash
docker run -d -p 8080:8080 -p 3389:3389 -e "TZ=Europe/Copenhagen" --name tinyMediaManager tmm

