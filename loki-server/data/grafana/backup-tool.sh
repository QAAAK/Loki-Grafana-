#!/bin/bash

# readme from https://hub.docker.com/r/ysde/docker-grafana-backup-tool

docker run --user $(id -u):$(id -g) --rm --name grafana-backup-tool \
           -v $pwd/backup/:/opt/grafana-backup-tool/_OUTPUT_ \
					 --env-file .env \
					 --network loki \
           ysde/docker-grafana-backup-tool
