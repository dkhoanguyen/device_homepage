#!/bin/bash

docker run -d -p 9090:80 \
    --domainname robotics_default.com \
    --name homepage device-homepage