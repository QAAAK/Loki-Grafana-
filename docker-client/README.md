# Установка и конфиг докер-хоста

1. docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
2. docker plugin ls
3. run docker container with changed logging path:

```bash
docker run --log-driver=loki \
    --log-opt loki-url="https://<user_id>:<password>@<DOMAIN_LOKI>/loki/api/v1/push" \
    --log-opt loki-retries=5 \
    --log-opt loki-batch-size=400 \
    hub/image
```

4. or set default setting of all container, located in /etc/docker/daemon.json

```json
{
    "debug" : true,
    "log-driver": "loki",
    "log-opts": {
        "loki-url": "https://<user_id>:<password>@<DOMAIN_LOKI>/loki/api/v1/push",
        "loki-batch-size": "400"
    }
}
```

# Upgrading plugin

The upgrade process involves disabling the existing plugin, upgrading, then re-enabling and restarting Docker:

```bash
docker plugin disable loki --force
docker plugin upgrade loki grafana/loki-docker-driver:latest --grant-all-permissions
docker plugin enable loki
systemctl restart docker
```

# Uninstalling plugin

To cleanly uninstall the plugin, disable and remove it:

```bash
docker plugin disable loki --force
docker plugin rm loki
```
