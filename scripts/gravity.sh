#!/bin/bash

PIHOLE_CONTAINER="pihole"

if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

if ! docker ps -a --format '{{.Names}}' | grep -Eq "^${PIHOLE_CONTAINER}$"
then
    echo "Container '${PIHOLE_CONTAINER}' does not exist. Please check the container name and try again."
    exit 1
fi

docker exec -it ${PIHOLE_CONTAINER} pihole -g

if [ $? -eq 0 ]; then
    echo "$(date): Pi-hole gravity list update completed successfully." | tee -a /var/log/pihole/pihole_update.log
else
    echo "$(date): Pi-hole gravity list update failed." | tee -a /var/log/pihole/pihole_update.log
fi
